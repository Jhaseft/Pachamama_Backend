import { ApiProperty } from "@nestjs/swagger";
import { IsOptional, IsUrl} from "class-validator";

export class UpdateSocialLinkDto {
    @ApiProperty({
        description: "URL de la red social",
        example: "https://www.twitter.com/username"
    })
    @IsOptional()
    @IsUrl()
    url?: string;
}