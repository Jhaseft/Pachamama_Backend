import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import { MessagesService } from './messages.service';
import { MessagesGateway } from './messages.gateway';

@Controller('messages')
export class MessagesController {
  constructor(
    private readonly messagesService: MessagesService,
    private readonly gateway: MessagesGateway,
  ) {}

  @Post()
  async sendMessage(@Body() body: { senderId: string; receiverId: string; text: string }) {
    const message = await this.messagesService.createMessage(
      body.senderId,
      body.receiverId,
      body.text,
    );

    this.gateway.sendMessageToUser(body.receiverId, message);

    return message;
  }

  @Get()
  getMessages(@Query('conversationId') conversationId: string) {
    return this.messagesService.getMessages(conversationId);
  }

  @Get('chats')
  getChats(@Query('userId') userId: string) {
    return this.messagesService.getChats(userId);
  }

  @Post('read')
  markAsRead(@Body() body: { conversationId: string; userId: string }) {
    return this.messagesService.markAsRead(body.conversationId, body.userId);
  }
}
