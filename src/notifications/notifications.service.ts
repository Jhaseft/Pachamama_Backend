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

    /**
     * Envío SOLO DATOS a navegadores.
     *
     * Un push con bloque `notification` lo muestra el navegador por su cuenta, y
     * además dispara onBackgroundMessage en el service worker, que la muestra otra
     * vez: el usuario ve la notificación duplicada. Mandando solo `data`, el
     * service worker es el único que la pinta (y así controla icono, clic y las
     * llamadas persistentes). El título y el cuerpo viajan dentro de `data`.
     */
    private async sendDataOnlyToWeb(tokens: string[], title: string, body: string, data?: any) {
        if (!admin.apps.length || !tokens.length) return;

        const stringData = data
            ? Object.fromEntries(Object.entries(data).map(([k, v]) => [k, String(v)]))
            : {};

        for (let i = 0; i < tokens.length; i += 500) {
            const chunk = tokens.slice(i, i + 500);
            try {
                const response = await admin.messaging().sendEachForMulticast({
                    tokens: chunk,
                    data: { ...stringData, title, body },
                    webpush: { headers: { Urgency: 'high' } },
                });

                response.responses.forEach((resp, idx) => {
                    if (!resp.success && resp.error?.code === 'messaging/registration-token-not-registered') {
                        this.removeDeadToken(chunk[idx]);
                    }
                });
            } catch (error) {
                console.error('🔥 Error enviando push web:', error);
            }
        }
    }

    // Tokens de un usuario, separados por destino.
    private async getTokensByPlatform(userIds: string[]) {
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

        const web = [...new Set(credentials.map((c) => c.token))];
        const webSet = new Set(web);
        const mobile = [...new Set(users.map((u) => u.fcmToken!))].filter((t) => !webSet.has(t));

        return { mobile, web };
    }

    // Notifica a un usuario en todos sus dispositivos (móvil y navegadores).
    async sendToUser(userId: string, title: string, body: string, data?: any) {
        await this.sendToUsers([userId], title, body, data);
    }

    // Notifica a varios usuarios (p. ej. suscriptores o admins).
    async sendToUsers(userIds: string[], title: string, body: string, data?: any) {
        if (!userIds.length) return;

        const { mobile, web } = await this.getTokensByPlatform(userIds);

        await Promise.all([
            mobile.length ? this.sendMulticastNotification(mobile, title, body, data) : null,
            web.length ? this.sendDataOnlyToWeb(web, title, body, data) : null,
        ]);
    }
}