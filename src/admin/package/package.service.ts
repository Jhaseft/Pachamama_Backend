import { Injectable, ConflictException, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../../prisma/prisma.service';
import { CreatePackageDto } from './dto/create-package.dto';
import { EditPackageDto } from './dto/edit-package.dto'; // Importa tu DTO de edición


@Injectable()
export class PackageService {
    constructor(private prisma: PrismaService) { }

    // CREAR UN PAQUETE UNICO
    async create(createPackageDto: CreatePackageDto) {
        const existingPackage = await this.prisma.package.findFirst({
            where: { name: createPackageDto.name },
        });

        if (existingPackage) {
            throw new ConflictException('Este nombre de paquete ya está registrado');
        }

        return this.prisma.package.create({
            data: createPackageDto,
        });
    }
    //

    // BUSCAR UN PAQUETE ESPESIFICO POR SU ID
    async findOne(id: string) {
        const pkg = await this.prisma.package.findUnique({
            where: { id }, // Aquí usamos el ID como criterio único
        });

        if (!pkg) {
            throw new NotFoundException(`No se encontró el paquete con ID: ${id}`);
        }
        return pkg;
    }

    //
    async findAll() {
        return this.prisma.package.findMany({
            where: { isActive: true }, // Opcional: solo traer los activos para el panel
        });
    }

    // EDITAR UN PAQUETE
    async update(id: string, editPackageDto: EditPackageDto) {
        // 1. Verificar si el paquete existe
        const pkg = await this.prisma.package.findUnique({
            where: { id },
        });

        if (!pkg) {
            throw new NotFoundException(`El paquete con ID ${id} no existe`);
        }

        // 2. Si se intenta cambiar el nombre, verificar que el nuevo no esté duplicado
        if (editPackageDto.name && editPackageDto.name !== pkg.name) {
            const nameExists = await this.prisma.package.findFirst({
                where: { name: editPackageDto.name },
            });
            if (nameExists) {
                throw new ConflictException('El nuevo nombre ya está en uso por otro paquete');
            }
        }

        // 3. Realizar la actualización en TablePlus
        return this.prisma.package.update({
            where: { id },
            data: editPackageDto,
        });
    }

    // ELIMINAR UN PAQUETE (SOFT DELETE)
    async remove(id: string) {
        const pkg = await this.prisma.package.findUnique({
            where: { id },
        });

        if (!pkg) {
            throw new NotFoundException(`No se puede eliminar: El paquete con ID ${id} no existe`);
        }

        return this.prisma.package.delete({
            where: { id },
        });
    }
}