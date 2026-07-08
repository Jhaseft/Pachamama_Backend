export class SocialLinkDto {
    id: string;
    socialNetworkId: string;
    url: string;
    socialNetwork: {
        id: string;
        name: string;
        icon: string;
        iconPublicId: string;
        createdAt: Date;
        updatedAt: Date;
    };
    createdAt: Date;
    updatedAt: Date;
}
