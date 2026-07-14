import { Injectable, OnModuleInit } from '@nestjs/common';
import * as admin from 'firebase-admin';
import { PrismaService } from '../prisma.service';

@Injectable()
export class NotificationsService implements OnModuleInit {
    constructor(private readonly prisma: PrismaService) {}
    onModuleInit() {
        if (!admin.apps.length) {
            try {
                const base64 = process.env.FIREBASE_SERVICE_ACCOUNT_BASE64;
                if (!base64) {
                    console.warn('⚠️  FIREBASE_SERVICE_ACCOUNT_BASE64 no configurado. Las notificaciones push estarán deshabilitadas.');
                    return;
                }
                const serviceAccount = JSON.parse(Buffer.from(base64, 'base64').toString('utf8'));
                admin.initializeApp({
                    credential: admin.credential.cert(serviceAccount),
                });
                console.log(`✅ Firebase inicializado correctamente. Proyecto: ${serviceAccount.project_id}`);
            } catch {
                console.warn('⚠️  Error inicializando Firebase. Las notificaciones push estarán deshabilitadas.');
            }
        }
    }
    

    async sendMulticastNotification(tokens: string[], title: string, body: string, data?: any) {
        if (!admin.apps.length) {
            console.warn('⚠️ Firebase no está inicializado');
            return;
        }

        const validTokens = tokens.filter(t => t && t.trim().length > 0);
        if (!validTokens.length) {
            console.warn('⚠️ No hay tokens válidos para enviar');
            return;
        }

        const stringData = data
            ? Object.fromEntries(Object.entries(data).map(([k, v]) => [k, String(v)]))
            : {};

        const chunks: string[][] = [];
        for (let i = 0; i < validTokens.length; i += 500) {
            chunks.push(validTokens.slice(i, i + 500));
        }

        for (const chunk of chunks) {
            try {
                const message: admin.messaging.MulticastMessage = {
                    tokens: chunk,
                    notification: { title, body },
                    data: stringData,
                    android: { priority: 'high', notification: { channelId: 'default' } },
                    apns: { payload: { aps: { contentAvailable: true } } },
                };

                const response = await admin.messaging().sendEachForMulticast(message);

                console.log('📤 Multicast enviado:', {
                    success: response.successCount,
                    failed: response.failureCount,
                });

                // Limpiar tokens obsoletos de la DB (móvil y navegadores)
                response.responses.forEach((resp, idx) => {
                    if (!resp.success && resp.error?.code === 'messaging/registration-token-not-registered') {
                        this.removeDeadToken(chunk[idx]);
                    }
                });
            } catch (error) {
                console.error('🔥 Error enviando multicast:', error);
            }
        }
    }

    async sendPushNotification(token: string, title: string, body: string, data?: any) {
        if (!admin.apps.length) {
            console.warn('⚠️ Firebase no está inicializado');
            return null;
        }

        if (!token) {
            console.warn('⚠️ Token vacío');
            return null;
        }

        const message: admin.messaging.Message = {
            token: token,
            notification: {
                title,
                body,
            },
            data: data
                ? Object.fromEntries(Object.entries(data).map(([k, v]) => [k, String(v)]))
                : {},
            android: {
                priority: 'high',
                notification: {
                    channelId: 'default',
                },
            },
            apns: {
                payload: {
                    aps: {
                        contentAvailable: true,
                    },
                },
            },
        };

        try {
            const response = await admin.messaging().send(message);

            console.log('✅ Notificación enviada:', response);

            return response;
        } catch (error: any) {
            console.error('🔥 Error enviando notificación:', {
                message: error?.message,
                code: error?.code,
                stack: error?.stack,
            });

            // 🔴 IMPORTANTE: NO lanzar error
            return null;
        }
    }

    // Borra un token que FCM reporta como inexistente: puede ser el del móvil
    // (users.fcmToken) o el de un navegador (web_push_credentials).
    private removeDeadToken(token: string) {
        this.prisma.user
            .updateMany({ where: { fcmToken: token }, data: { fcmToken: null } })
            .catch(() => {});
        this.prisma.webPushCredential
            .deleteMany({ where: { token } })
            .catch(() => {});
    }

    // Todos los destinos de un usuario: su móvil + cada navegador registrado.
    async getUserTokens(userId: string): Promise<string[]> {
        const [user, credentials] = await Promise.all([
            this.prisma.user.findUnique({
                where: { id: userId },
                select: { fcmToken: true },
            }),
            this.prisma.webPushCredential.findMany({
                where: { userId },
                select: { token: true },
            }),
        ]);

        const tokens = [
            ...(user?.fcmToken ? [user.fcmToken] : []),
            ...credentials.map((c) => c.token),
        ];

        return [...new Set(tokens)];
    }

    // Notifica a un usuario en todos sus dispositivos.
    async sendToUser(userId: string, title: string, body: string, data?: any) {
        const tokens = await this.getUserTokens(userId);
        if (!tokens.length) return;
        await this.sendMulticastNotification(tokens, title, body, data);
    }

    // Notifica a varios usuarios (p. ej. suscriptores o admins).
    async sendToUsers(userIds: string[], title: string, body: string, data?: any) {
        if (!userIds.length) return;

        const [users, credentials] = await Promise.all([
            this.prisma.user.findMany({
                where: { id: { in: userIds }, fcmToken: { not: null } },
                select: { fcmToken: true },
            }),
            this.prisma.webPushCredential.findMany({
                where: { userId: { in: userIds } },
                select: { token: true },
            }),
        ]);

        const tokens = [
            ...users.map((u) => u.fcmToken!),
            ...credentials.map((c) => c.token),
        ];

        if (!tokens.length) return;
        await this.sendMulticastNotification([...new Set(tokens)], title, body, data);
    }
}