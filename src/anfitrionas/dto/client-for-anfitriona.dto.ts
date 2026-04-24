export class ClientForAnfitrianaDto {
  id: string;
  name: string;
  avatar: string | null;
  lastActiveAt: string | null;
  hasConversation: boolean;
  conversationId: string | null;
}

export class ClientsForAnfitrianaResponseDto {
  data: ClientForAnfitrianaDto[];
  nextCursor: string | null;
}
