import { Body, Controller, Get, Param, Post, Query, UseGuards, UseInterceptors, UploadedFile, BadRequestException, Request } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { memoryStorage } from 'multer';
import { UserRole } from '@prisma/client';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { Roles } from '../auth/decorators/roles.decorator';
import { CurrentUser } from '../auth/decorators/current-user.decorator';
import { MessagesService } from './messages.service';
import { MessagesGateway } from './messages.gateway';
import { CloudinaryService } from '../cloudinary/cloudinary.service';

interface JwtUser {
  userId: string;
  role: UserRole;
}

@UseGuards(JwtAuthGuard)
@Controller('messages')
export class MessagesController {
  constructor(
    private readonly messagesService: MessagesService,
    private readonly gateway: MessagesGateway,
    private readonly cloudinaryService: CloudinaryService,
  ) {}

  // POST /messages — enviar mensaje (con isLocked opcional)
  @Post()
  async sendMessage(
    @CurrentUser() user: JwtUser,
    @Body() body: { receiverId: string; text: string; isLocked?: boolean },
  ) {
    const message = await this.messagesService.createMessage(
      user.userId,
      body.receiverId,
      body.text,
      body.isLocked ?? false,
    );

    this.gateway.sendMessageToUser(body.receiverId, message);

    return message;
  }

  // GET /messages?conversationId=xxx — obtener mensajes de una conversación
  @Get()
  getMessages(
    @CurrentUser() user: JwtUser,
    @Query('conversationId') conversationId: string,
  ) {
    return this.messagesService.getMessages(conversationId, user.userId);
  }

  // GET /messages/chats — obtener lista de conversaciones
  @Get('chats')
  getChats(@CurrentUser() user: JwtUser) {
    return this.messagesService.getChats(user.userId);
  }

  // POST /messages/:id/unlock — desbloquear un mensaje pagando créditos
  @Post(':id/unlock')
  unlockMessage(@CurrentUser() user: JwtUser, @Param('id') messageId: string) {
    return this.messagesService.unlockMessage(messageId, user.userId);
  }

  // POST /messages/image — solo ANFITRIONA puede enviar imágenes en el chat
  @Post('image')
  @UseGuards(RolesGuard)
  @Roles(UserRole.ANFITRIONA)
  @UseInterceptors(FileInterceptor('file', { storage: memoryStorage() }))
  async sendImage(
    @CurrentUser() user: JwtUser,
    @Body() body: { receiverId: string; isLocked?: string; price?: string },
    @UploadedFile() file: Express.Multer.File,
  ) {
    if (!file) throw new BadRequestException('Debes subir una imagen');

    const isLocked = body.isLocked === 'true';
    const price = body.price ? Number(body.price) : undefined;

    if (isLocked && (!price || price <= 0)) {
      throw new BadRequestException('Debes definir un precio mayor a 0 para imagen bloqueada');
    }

    // Subir imagen a Cloudinary
    const uploaded = await this.cloudinaryService.uploadChatImage({
      file,
      senderId: user.userId,
    });

    const message = await this.messagesService.createMessage(
      user.userId,
      body.receiverId,
      null,
      isLocked,
      uploaded.secureUrl,
      uploaded.publicId,
      price,
    );

    // Emitir via socket al receptor
    this.gateway.sendMessageToUser(body.receiverId, message);

    return message;
  }

  // POST /messages/:id/unlock-image — cliente desbloquea imagen pagando créditos
  @Post(':id/unlock-image')
  unlockChatImage(@CurrentUser() user: JwtUser, @Param('id') messageId: string) {
    return this.messagesService.unlockChatImage(messageId, user.userId);
  }

  // GET /messages/my-unlocked-images — galería de imágenes desbloqueadas del cliente
  @Get('my-unlocked-images')
  getMyUnlockedImages(@CurrentUser() user: JwtUser) {
    return this.messagesService.getMyUnlockedImages(user.userId);
  }

  // POST /messages/expire — forzar limpieza manual (útil para testing)
  @Post('expire')
  triggerExpire() {
    return this.messagesService.deleteExpiredMessages();
  }

  // POST /messages/read — marcar mensajes como leídos
  @Post('read')
  markAsRead(
    @CurrentUser() user: JwtUser,
    @Body() body: { conversationId: string },
  ) {
    return this.messagesService.markAsRead(body.conversationId, user.userId);
  }
}
