import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';

@Injectable()
export class MessagesService {
  constructor(private readonly prisma: PrismaService) {}

  async createMessage(senderId: string, receiverId: string, text: string) {
    // Normalizar el orden para garantizar el @@unique([user1Id, user2Id])
    const [user1Id, user2Id] = [senderId, receiverId].sort();

    const conversation = await this.prisma.conversation.upsert({
      where: { user1Id_user2Id: { user1Id, user2Id } },
      create: { user1Id, user2Id },
      update: {},
    });

    const message = await this.prisma.message.create({
      data: {
        conversationId: conversation.id,
        senderId,
        text,
      },
    });

    return { ...message, conversationId: conversation.id };
  }

  async getMessages(conversationId: string) {
    return this.prisma.message.findMany({
      where: { conversationId },
      orderBy: { createdAt: 'asc' },
    });
  }

  async getChats(userId: string) {
    const conversations = await this.prisma.conversation.findMany({
      where: {
        OR: [{ user1Id: userId }, { user2Id: userId }],
      },
      include: {
        messages: {
          orderBy: { createdAt: 'desc' },
          take: 1,
        },
      },
      orderBy: { updatedAt: 'desc' },
    });

    const chats = await Promise.all(
      conversations.map(async (conv) => {
        const otherUserId = conv.user1Id === userId ? conv.user2Id : conv.user1Id;
        const lastMessage = conv.messages[0] ?? null;

        const unreadCount = await this.prisma.message.count({
          where: {
            conversationId: conv.id,
            read: false,
            senderId: { not: userId },
          },
        });

        return {
          conversationId: conv.id,
          otherUserId,
          lastMessage: lastMessage?.text ?? null,
          lastMessageAt: lastMessage?.createdAt ?? conv.createdAt,
          unreadCount,
        };
      }),
    );

    return chats.sort((a, b) => {
      if (a.unreadCount > 0 && b.unreadCount === 0) return -1;
      if (a.unreadCount === 0 && b.unreadCount > 0) return 1;
      return b.lastMessageAt.getTime() - a.lastMessageAt.getTime();
    });
  }

  async markAsRead(conversationId: string, userId: string) {
    await this.prisma.message.updateMany({
      where: {
        conversationId,
        senderId: { not: userId },
        read: false,
      },
      data: { read: true },
    });

    return { success: true };
  }
}
