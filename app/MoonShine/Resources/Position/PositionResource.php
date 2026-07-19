<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\Position;

use Illuminate\Database\Eloquent\Model;
use App\Models\Position;

use MoonShine\Laravel\Fields\Relationships\BelongsTo;
use App\MoonShine\Resources\Shift\ShiftResource;

use App\MoonShine\Resources\Position\Pages\PositionIndexPage;
use App\MoonShine\Resources\Position\Pages\PositionFormPage;
use App\MoonShine\Resources\Position\Pages\PositionDetailPage;

use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\Support\Enums\PageType;
use MoonShine\Contracts\Core\PageContract;
use MoonShine\UI\Fields\Text;

/**
 * @extends ModelResource<Position, PositionIndexPage, PositionFormPage, PositionDetailPage>
 */
class PositionResource extends ModelResource
{
    protected string $model = Position::class;

    protected string $title = 'Positions';
    protected string $column = 'name';
    protected ?PageType $redirectAfterSave = PageType::INDEX;
    /**
     * @return list<class-string<PageContract>>
     */
    protected function pages(): array
    {
        return [
            PositionIndexPage::class,
            PositionFormPage::class,
        ];
    }
    public function formFields(): array
    {
        return [
            Text::make('Kode Jabatan', 'code')->required(),
            Text::make('Nama Jabatan', 'name')->required(),
            BelongsTo::make('Shift Kerja', 'shift', resource: ShiftResource::class)
                ->nullable() // Jaga-jaga kalau ada posisi yang tidak punya shift tetap
                ->searchable(),
        ];
    }
    public function fields(): array
    {
        return [
            Text::make('Kode', 'code')->sortable(),
            Text::make('Nama Jabatan', 'name')->sortable(),
            Text::make('Shift', 'shift.name')->sortable(),
        ];
    }
}
