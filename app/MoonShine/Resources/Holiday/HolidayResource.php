<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\Holiday;

use Illuminate\Database\Eloquent\Model;
use App\Models\Holiday;
use App\MoonShine\Resources\Holiday\Pages\HolidayIndexPage;
use App\MoonShine\Resources\Holiday\Pages\HolidayFormPage;
use App\MoonShine\Resources\Holiday\Pages\HolidayDetailPage;
use MoonShine\Support\Enums\PageType;

use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\Contracts\Core\PageContract;
use MoonShine\UI\Fields\Text;
use MoonShine\UI\Fields\Select;
use MoonShine\UI\Fields\Date;

/**
 * @extends ModelResource<Holiday, HolidayIndexPage, HolidayFormPage, HolidayDetailPage>
 */
class HolidayResource extends ModelResource
{
    protected string $model = Holiday::class;

    protected string $title = 'Holidays';
    protected ?PageType $redirectAfterSave = PageType::INDEX;
    protected int    $itemsPerPage  = 10;
    protected bool   $usePagination = true;

    
    public function getItemsPerPage(): int
    {
        $default = $this->itemsPerPage;
        $value   = (int) (session()?->get('appMetricPerPage') ?? $default);

        return in_array($value, $this->perPageValues()) ? $value : $default;
    }

    protected function perPageValues(): array
    {
        return [10, 25, 50, 100];
    }

    public function fields(): array
    {
        return [
            Date::make('Tanggal Libur', 'date')->required()->format('d M Y'),
            Text::make('Keterangan', 'description')->required(),
            Select::make('Jenis Libur', 'is_national')->options([
                1 => 'Libur Nasional',
                0 => 'Libur Khusus Perusahaan / Cuti Bersama',
            ]),
        ];
    }
    /**
     * @return list<class-string<PageContract>>
     */
    protected function pages(): array
    {
        return [
            HolidayIndexPage::class,
            HolidayFormPage::class,
            HolidayDetailPage::class,
        ];
    }
}
