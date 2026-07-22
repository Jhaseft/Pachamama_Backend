import {
  Injectable,
  ConflictException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { CreateCategoryDto } from './dto/create-category.dto';
import { UpdateCategoryDto } from './dto/update-category.dto';

/** Convierte "Música en Vivo" -> "musica-en-vivo" */
function slugify(text: string): string {
  return text
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '') // quita acentos/diacríticos
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

const withCreatorCount = <T extends { _count?: { creators: number } }>(
  category: T,
) => {
  const { _count, ...rest } = category;
  return { ...rest, creatorsCount: _count?.creators ?? 0 };
};

const COUNT_INCLUDE = { _count: { select: { creators: true } } } as const;

@Injectable()
export class CategoriesService {
  constructor(private prisma: PrismaService) {}

  /** Público: categorías activas con conteo de creadores (explorar / selección). */
  async findActive() {
    const categories = await this.prisma.category.findMany({
      where: { isActive: true },
      orderBy: { name: 'asc' },
      include: COUNT_INCLUDE,
    });
    return categories.map(withCreatorCount);
  }

  /** Admin: todas las categorías (activas e inactivas) con conteo. */
  async findAll() {
    const categories = await this.prisma.category.findMany({
      orderBy: { name: 'asc' },
      include: COUNT_INCLUDE,
    });
    return categories.map(withCreatorCount);
  }

  async create(dto: CreateCategoryDto) {
    const name = dto.name.trim();
    const slug = (dto.slug?.trim() || slugify(name)) || null;

    const existing = await this.prisma.category.findFirst({
      where: { OR: [{ name }, ...(slug ? [{ slug }] : [])] },
    });
    if (existing) {
      throw new ConflictException(
        'Ya existe una categoría con ese nombre o slug',
      );
    }

    const category = await this.prisma.category.create({
      data: {
        name,
        slug,
        description: dto.description?.trim() || null,
        icon: dto.icon?.trim() || null,
        isActive: dto.isActive ?? true,
      },
      include: COUNT_INCLUDE,
    });
    return withCreatorCount(category);
  }

  async update(id: string, dto: UpdateCategoryDto) {
    const category = await this.prisma.category.findUnique({ where: { id } });
    if (!category) {
      throw new NotFoundException(`La categoría con ID ${id} no existe`);
    }

    const data: {
      name?: string;
      slug?: string | null;
      description?: string | null;
      icon?: string | null;
      isActive?: boolean;
    } = {};

    if (dto.name !== undefined) data.name = dto.name.trim();
    if (dto.slug !== undefined) data.slug = dto.slug?.trim() || null;
    if (dto.description !== undefined)
      data.description = dto.description?.trim() || null;
    if (dto.icon !== undefined) data.icon = dto.icon?.trim() || null;
    if (dto.isActive !== undefined) data.isActive = dto.isActive;

    if (data.name && data.name !== category.name) {
      const dup = await this.prisma.category.findFirst({
        where: { name: data.name, NOT: { id } },
      });
      if (dup) {
        throw new ConflictException('Ya existe otra categoría con ese nombre');
      }
    }

    if (data.slug && data.slug !== category.slug) {
      const dup = await this.prisma.category.findFirst({
        where: { slug: data.slug, NOT: { id } },
      });
      if (dup) {
        throw new ConflictException('Ya existe otra categoría con ese slug');
      }
    }

    const updated = await this.prisma.category.update({
      where: { id },
      data,
      include: COUNT_INCLUDE,
    });
    return withCreatorCount(updated);
  }

  /**
   * Elimina la categoría. Las asociaciones con creadores se borran en cascada
   * (anfitrione_profile_categories), no se toca al creador en sí.
   */
  async remove(id: string) {
    const category = await this.prisma.category.findUnique({ where: { id } });
    if (!category) {
      throw new NotFoundException(
        `No se puede eliminar: la categoría con ID ${id} no existe`,
      );
    }

    await this.prisma.category.delete({ where: { id } });
    return { id, deleted: true };
  }
}
