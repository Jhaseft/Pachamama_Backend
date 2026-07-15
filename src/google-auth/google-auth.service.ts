import { Injectable, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { OAuth2Client } from 'google-auth-library';

export interface GoogleUserPayload {
  email: string;
  firstName: string;
  lastName: string;
  picture: string | null;
}

@Injectable()
export class GoogleAuthService {
  private client: OAuth2Client;
  private audiences: string[];

  constructor(private configService: ConfigService) {
    const webClientId = this.configService.get<string>('GOOGLE_MOBILE_WEB_CLIENT_ID') ?? '';
    const iosClientId = this.configService.get<string>('GOOGLE_MOBILE_IOS_CLIENT_ID') ?? '';
    // Client id del navegador (Pacha-Web). El token que emite Google Identity
    // Services en la web trae este `aud`; sin él, verifyIdToken lo rechaza.
    const browserWebClientId = this.configService.get<string>('GOOGLE_WEB_CLIENT_ID') ?? '';

    this.audiences = [webClientId, iosClientId, browserWebClientId].filter(Boolean);
    this.client = new OAuth2Client();
  }

  async verifyIdToken(idToken: string): Promise<GoogleUserPayload> {
    let ticket;
    try {
      ticket = await this.client.verifyIdToken({
        idToken,
        audience: this.audiences,
      });
    } catch {
      throw new UnauthorizedException('Token de Google inválido o expirado');
    }

    const payload = ticket.getPayload();
    if (!payload || !payload.email) {
      throw new UnauthorizedException('No se pudo obtener el email de Google');
    }

    return {
      email: payload.email.toLowerCase(),
      firstName: payload.given_name ?? '',
      lastName: payload.family_name ?? '',
      picture: payload.picture ?? null,
    };
  }
}
