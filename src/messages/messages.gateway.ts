import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { MessagesService } from './messages.service';
import { CallsService } from '../calls/calls.service';
import { NotificationsService } from '../notifications/notifications.service';
import { PrismaService } from '../prisma.service';

interface CallSession {
  callerId: string;
  anfitrionaId: string;
  callType: 'CALL' | 'VIDEO_CALL';
  startedAt: number | null;
  warningInterval?: NodeJS.Timeout;
}

@WebSocketGateway({
  cors: {
    origin: '*',
  },
})
export class MessagesGateway implements OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  private readonly callSessions = new Map<string, CallSession>();
  // socketId → userId
  private readonly presenceMap = new Map<string, string>();

  constructor(
    private readonly messagesService: MessagesService,
    private readonly callsService: CallsService,
    private readonly notificationsService: NotificationsService,
    private readonly prisma: PrismaService,
  ) {}

  @SubscribeMessage('register')
  async handleRegister(
    @MessageBody() userId: string,
    @ConnectedSocket() client: Socket,
  ) {
    client.join(`user_${userId}`);
    this.presenceMap.set(client.id, userId);

    const now = new Date();
    await this.prisma.user.update({
      where: { id: userId },
      data: { lastActiveAt: now },
    });

    await this.emitPresenceToConversationPartners(userId, true, now);
    await this.emitPresenceSnapshotToClient(userId, client);
  }

  async handleDisconnect(client: Socket) {
    const userId = this.presenceMap.get(client.id);
    if (!userId) return;

    this.presenceMap.delete(client.id);

    // If the user has more active connections, don't mark them offline
    const stillConnected = Array.from(this.presenceMap.values()).some(
      (id) => id === userId,
    );
    if (stillConnected) return;

    // Do NOT update lastActiveAt here — closing the app is not user activity.
    // Read the last recorded value to pass it in the presence event.
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { lastActiveAt: true },
    });

    await this.emitPresenceToConversationPartners(
      userId,
      false,
      user?.lastActiveAt ?? new Date(),
    );
  }

  private async emitPresenceToConversationPartners(
    userId: string,
    isOnline: boolean,
    lastActiveAt: Date,
  ) {
    const conversations = await this.prisma.conversation.findMany({
      where: { OR: [{ user1Id: userId }, { user2Id: userId }] },
      select: { user1Id: true, user2Id: true },
    });

    const partnerIds = conversations.map((c) =>
      c.user1Id === userId ? c.user2Id : c.user1Id,
    );

    const payload = {
      userId,
      isOnline,
      lastActiveAt: lastActiveAt.toISOString(),
    };

    for (const partnerId of partnerIds) {
      this.server.to(`user_${partnerId}`).emit('user_presence', payload);
    }
  }

  private async emitPresenceSnapshotToClient(userId: string, client: Socket) {
    const conversations = await this.prisma.conversation.findMany({
      where: { OR: [{ user1Id: userId }, { user2Id: userId }] },
      select: { user1Id: true, user2Id: true },
    });

    if (conversations.length === 0) return;

    const partnerIds = Array.from(
      new Set(
        conversations.map((c) => (c.user1Id === userId ? c.user2Id : c.user1Id)),
      ),
    );

    const partners = await this.prisma.user.findMany({
      where: { id: { in: partnerIds } },
      select: { id: true, lastActiveAt: true },
    });

    const partnerById = new Map(partners.map((p) => [p.id, p]));

    for (const partnerId of partnerIds) {
      const partner = partnerById.get(partnerId);
      const isOnline = Array.from(this.presenceMap.values()).some(
        (id) => id === partnerId,
      );

      client.emit('user_presence', {
        userId: partnerId,
        isOnline,
        lastActiveAt: partner?.lastActiveAt?.toISOString() ?? null,
      });
    }
  }

  @SubscribeMessage('send_message')
  async handleMessage(
    @MessageBody() data: { senderId: string; receiverId: string; text?: string; imageUrl?: string; isLocked?: boolean },
    @ConnectedSocket() client: Socket,
  ) {
    const message = await this.messagesService.createMessage(
      data.senderId,
      data.receiverId,
      data.text ?? null,
      data.isLocked ?? false,
    );

    // Sending a message is explicit user activity
    const now = new Date();
    await this.prisma.user.update({
      where: { id: data.senderId },
      data: { lastActiveAt: now },
    });
    await this.emitPresenceToConversationPartners(data.senderId, true, now);

    this.sendMessageToUser(data.receiverId, message);
    client.emit('message_sent', message);
  }

  sendMessageToUser(userId: string, message: any) {
    this.server.to(`user_${userId}`).emit('new_message', message);
  }

  // ── LLAMADAS ──────────────────────────────────────────────────────────────

  @SubscribeMessage('call_request')
  async handleCallRequest(
    @MessageBody()
    data: {
      callId: string;
      callerId: string;
      receiverId: string;
      callType: 'CALL' | 'VIDEO_CALL';
      callerName: string;
      callerAvatar: string | null;
      pricePerMinute: number;
    },
    @ConnectedSocket() client: Socket,
  ) {
    this.callSessions.set(data.callId, {
      callerId: data.callerId,
      anfitrionaId: data.receiverId,
      callType: data.callType,
      startedAt: null,
    });

    this.server.to(`user_${data.receiverId}`).emit('incoming_call', data);
    client.emit('call_ringing', { callId: data.callId });

    // Push a la anfitriona por si tiene la app cerrada. Va el payload completo:
    // si la web estaba cerrada no recibió el evento del socket, así que necesita
    // reconstruir la llamada entrante a partir de la notificación.
    const label = data.callType === 'VIDEO_CALL' ? 'Video llamada' : 'Llamada de voz';
    this.notificationsService.sendToUser(
      data.receiverId,
      `📞 ${label} entrante`,
      `${data.callerName} te está llamando`,
      {
        type: 'INCOMING_CALL',
        callId: data.callId,
        callerId: data.callerId,
        receiverId: data.receiverId,
        callType: data.callType,
        callerName: data.callerName,
        callerAvatar: data.callerAvatar ?? '',
        pricePerMinute: data.pricePerMinute,
      }
    );
  }

  @SubscribeMessage('call_accepted')
  async handleCallAccepted(
    @MessageBody() data: { callId: string; callerId: string; anfitrionaName: string },
    @ConnectedSocket() _client: Socket,
  ) {
    const session = this.callSessions.get(data.callId);
    if (session) session.startedAt = Date.now();

    this.server.to(`user_${data.callerId}`).emit('call_accepted', { callId: data.callId });

    // Iniciar intervalo de advertencia cada 2 minutos
    if (session) {
      session.warningInterval = setInterval(async () => {
        // La consulta sigue haciendo falta: el saldo va en el cuerpo del aviso.
        const caller = await this.prisma.user.findUnique({
          where: { id: session.callerId },
          select: { wallet: { select: { balance: true } } },
        });

        if (caller?.wallet) {
          const balance = Number(caller.wallet.balance);
          this.notificationsService.sendToUser(
            session.callerId,
            '⏱️ Llamada en curso',
            `Te quedan ${balance} créditos`,
            { callId: data.callId, type: 'CALL_WARNING', balance: balance }
          );
        }
      }, 2 * 60 * 1000); // cada 2 minutos
    }

    // Push al cliente
    this.notificationsService.sendToUser(
      data.callerId,
      '✅ Llamada aceptada',
      `${data.anfitrionaName} aceptó tu llamada`,
      { callId: data.callId, type: 'CALL_ACCEPTED' }
    );
  }

  @SubscribeMessage('call_rejected')
  async handleCallRejected(
    @MessageBody() data: { callId: string; callerId: string; anfitrionaName: string },
    @ConnectedSocket() _client: Socket,
  ) {
    const session = this.callSessions.get(data.callId);
    if (session?.warningInterval) clearInterval(session.warningInterval);
    this.callSessions.delete(data.callId);
    this.server.to(`user_${data.callerId}`).emit('call_rejected', { callId: data.callId });

    // Push al cliente
    this.notificationsService.sendToUser(
      data.callerId,
      '❌ Llamada rechazada',
      `${data.anfitrionaName} no está disponible`,
      { callId: data.callId, type: 'CALL_REJECTED' }
    );
  }

  @SubscribeMessage('call_ended')
  async handleCallEnded(
    @MessageBody() data: { callId: string; otherUserId: string },
    @ConnectedSocket() _client: Socket,
  ) {
    const session = this.callSessions.get(data.callId);
    this.callSessions.delete(data.callId);

    // Limpiar intervalo de advertencia
    if (session?.warningInterval) clearInterval(session.warningInterval);

    // Notificar a ambos participantes usando los IDs del session map
    if (session) {
      this.server.to(`user_${session.callerId}`).emit('call_ended', { callId: data.callId });
      this.server.to(`user_${session.anfitrionaId}`).emit('call_ended', { callId: data.callId });
    } else {
      this.server.to(`user_${data.otherUserId}`).emit('call_ended', { callId: data.callId });
    }

    // Facturar si la llamada efectivamente conectó
    if (session?.startedAt) {
      const durationSeconds = Math.floor((Date.now() - session.startedAt) / 1000);
      try {
        const billing = await this.callsService.billCall(
          session.callerId,
          session.anfitrionaId,
          session.callType,
          durationSeconds,
        );
        // Notificar resultado de facturación a ambos lados
        const billingResult = { ...billing, durationSeconds };
        this.server.to(`user_${session.callerId}`).emit('call_billed', billingResult);
        this.server.to(`user_${session.anfitrionaId}`).emit('call_billed', billingResult);

        // Push a ambos con el resultado de facturación
        this.notificationsService.sendToUser(
          session.callerId,
          '💰 Llamada finalizada',
          `Se cobraron ${billing.creditsCharged} créditos · ${billing.minutesBilled} min`,
          { callId: data.callId, type: 'CALL_BILLED', ...billingResult }
        );
        this.notificationsService.sendToUser(
          session.anfitrionaId,
          '💰 Llamada finalizada',
          `Ganaste ${billing.creditsCharged} créditos · ${billing.minutesBilled} min`,
          { callId: data.callId, type: 'CALL_BILLED', ...billingResult }
        );
      } catch (err) {
        console.error('[CallBilling] Error al facturar llamada:', err);
      }
    }
  }
}
