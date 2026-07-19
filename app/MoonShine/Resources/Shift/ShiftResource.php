<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\Shift;

use Illuminate\Database\Eloquent\Model;
use App\Models\Shift;
use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\UI\Fields\ID;
use MoonShine\UI\Fields\Text;
use MoonShine\UI\Fields\Date; // 🟢 GANTI INI: Gunakan Date field bawaan MoonShine
use MoonShine\Support\Enums\PageType;

use App\MoonShine\Resources\Shift\Pages\ShiftIndexPage;
use App\MoonShine\Resources\Shift\Pages\ShiftFormPage;
use App\MoonShine\Resources\Shift\Pages\ShiftDetailPage;

class ShiftResource extends ModelResource
{
    protected string $model = Shift::class;
    protected string $title = 'Master Shifts';
    protected string $column = 'name';
    protected ?PageType $redirectAfterSave = PageType::INDEX;

    public function fields(): array
    {
        return [
            Text::make('Nama Shift', 'name')->required(),
            
            // 🟢 Alternatif menggunakan Text field yang diubah menjadi input time
            Text::make('Jam Masuk', 'clock_in')
                ->setAttribute('type', 'time')
                ->required(),
                
            Text::make('Jam Pulang', 'clock_out')
                ->setAttribute('type', 'time')
                ->required(),
        ];
    }

    public function rules(mixed $item): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'clock_in' => ['required', 'date_format:H:i'],
            'clock_out' => ['required', 'date_format:H:i'],
        ];
    }

    protected function pages(): array
    {
        return [
            ShiftIndexPage::class,
            ShiftFormPage::class,
            ShiftDetailPage::class,
        ];
    }
}