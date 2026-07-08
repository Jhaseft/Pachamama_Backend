import { IsString, IsUUID, IsUrl } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";

export class CreateSocialLinkDto {
    @ApiProperty({
        description: "ID de la red social",
        example: 'b1a2c3d4-e5f6-7g8h-9i0j-k1l2m3n4o5p6',
        format: 'uuid',
    })
    @IsUUID()
    socialNetworkId: string;

    @ApiProperty({
        description: "la URL de la red social",
        example: 'https://www.instagram.com/username'
    })
    @IsUrl()
    url: string;
}