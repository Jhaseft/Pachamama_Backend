import { Controller, Post, Body, Get, Patch, Param, Delete } from '@nestjs/common';
import { PackageService } from './package.service';
import { CreatePackageDto } from './dto/create-package.dto';
import { EditPackageDto } from './dto/edit-package.dto';
import { ApiTags, ApiOperation } from '@nestjs/swagger';


@ApiTags('Packages')
@Controller('packages') // Define la ruta base para este controlador, por ejemplo: /packages
export class PackageController {
  constructor(private readonly packageService: PackageService) {}

  //CREAR UN PAQUETE NUEVO
  @Post('create')// Puedes ajustar la ruta si quieres, por ejemplo: /packages/create
  @ApiOperation({ summary: 'Crear un nuevo paquete de suscripción' })
  create(@Body() createPackageDto: CreatePackageDto) {
    // Llama al servicio que valida el nombre único antes de crear
    return this.packageService.create(createPackageDto);
  }

  //LISTA TODOS LOS PAQUETES ACTIVOS
  @Get()
  @ApiOperation({ summary: 'Listar todos los paquetes activos' })
  findAll() {
    return this.packageService.findAll();
  }

  //OBTENER UN PAQUETE POR SU ID
  @Get(':id')
  @ApiOperation({ summary: 'Obtener un paquete específico por ID' })
  findOne(@Param('id') id: string) {
    return this.packageService.findOne(id);
  }

  //EDITAR UN PAQUETE EXISTENTE
  @Patch(':id')
  @ApiOperation({ summary: 'Editar un paquete existente' })
  update(@Param('id') id: string, @Body() editPackageDto: EditPackageDto) {
    // Utiliza el DTO de edición donde los campos son opcionales
    return this.packageService.update(id, editPackageDto);
  }

  //ELIMINAR UN PAQUETE (SOFT DELETE)
  @Delete(':id')
  @ApiOperation({ summary: 'Desactivar un paquete (Soft Delete)' })
  remove(@Param('id') id: string) {
    return this.packageService.remove(id);
  }
}