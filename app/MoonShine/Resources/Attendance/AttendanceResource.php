<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\Attendance;

use Illuminate\Database\Eloquent\Model;
use App\Models\Attendance;
use App\MoonShine\Resources\Attendance\Pages\AttendanceIndexPage;
use App\MoonShine\Resources\Attendance\Pages\AttendanceFormPage;
use App\MoonShine\Resources\Attendance\Pages\AttendanceDetailPage;
use MoonShine\Laravel\Fields\Relationships\BelongsTo;
use MoonShine\UI\Fields\Date;
use MoonShine\UI\Fields\Select;
use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\Contracts\Core\PageContract;
use MoonShine\Support\Enums\PageType;
use MoonShine\UI\Fields\Text;
use Illuminate\Support\Carbon;

/**
 * @extends ModelResource<Attendance, AttendanceIndexPage, AttendanceFormPage, AttendanceDetailPage>
 */
class AttendanceResource extends ModelResource
{
    protected string $model = Attendance::class;

    protected string $title = 'Attendances';
    protected ?PageType $redirectAfterSave = PageType::INDEX;
    
    protected string $sortColumn    = 'date';
    protected int    $itemsPerPage  = 10;
    protected bool   $usePagination = true;

    
    public function getItemsPerPage(): int
    {
        $default = $this->itemsPerPage;
        $value   = (int) (session()?->get('appMetricPerPage') ?? $default);

        return in_array($value, $this->perPageValues()) ? $value : $default;
    }

    public function perPageValues(): array
    {
        return [
            10  => 10,
            25  => 25,
            50  => 50,
            100 => 100,
        ];
    }

    public function search(): array
    {
        return ['employee.name','status'];
    }
    
    public function formFields(): array
    {
        return [
            BelongsTo::make('Karyawan', 'employee', fn($item) => $item->name)
                ->sortable()
                ->searchable()
                ->required(),

            Date::make('Tanggal', 'date')
                ->default(now()->toDateString()) 
                ->required()
                ->format('d M Y'),

            Text::make('Jam Masuk', 'clock_in')
                ->setAttribute('type', 'time')
                ->default(now()->format('H:i')),

            Text::make('Jam Pulang', 'clock_out')
                ->setAttribute('type', 'time'),

            Select::make('Status', 'status')
                ->options([
                    'hadir' => 'Hadir tepat waktu',
                    'terlambat' => 'Terlambat',
                    'izin' => 'Izin / Sakit',
                    'alpa' => 'Alpa / Tanpa Keterangan',
                ])
                ->required(),
        ];
    }
    public function fields(): array
    {
        $fields = [
            // Relasi ke karyawan (Dropdown pilih karyawan)
            BelongsTo::make('Karyawan', 'employee', fn($item) => $item->name)
                ->sortable()
                ->searchable()
                ->required(),

            Date::make('Tanggal', 'date')
                ->sortable()
                ->required()
                ->format('d M Y'),

            Text::make('Jam Masuk', 'clock_in')
                ->setAttribute('type', 'time') // Tetap memunculkan picker jam di browser
                ->required()
                ->onApply(function ($item, $value) {
                    $item->clock_in = $value ? date('H:i', strtotime((string) $value)) : null;
                    return $item;
                }),

            Text::make('Jam Pulang', 'clock_out')
                ->setAttribute('type', 'time') // Tetap memunculkan picker jam di browser
                ->onApply(function ($item, $value) {
                    $item->clock_out = $value ? date('H:i', strtotime((string) $value)) : null;
                    return $item;
                }),
        ];
        $fields[] = Text::make('Total Jam Kerja', 'total_hours', function($item) {
            if (!$item->clock_in || !$item->clock_out) {
                return '-';
            }
            try {
                $masuk = Carbon::parse($item->clock_in);
                $pulang = Carbon::parse($item->clock_out);
                if ($pulang->lessThan($masuk)) {
                    $pulang->addDay();
                }
                $totalMenit = $masuk->diffInMinutes($pulang);
                $jam = floor($totalMenit / 60);
                $menit = $totalMenit % 60;
                return $menit > 0 ? "{$jam} Jam {$menit} Menit" : "{$jam} Jam";
            } catch (\Exception $e) {
                return '-';
            }
        });
        $fields[] = Select::make('Status', 'status')
            ->options([
                'hadir' => 'Hadir tepat waktu',
                'terlambat' => 'Terlambat',
                'izin' => 'Izin / Sakit',
                'alpa' => 'Alpa / Tanpa Keterangan',
            ])
            ->badge(fn($value) => match($value) {
                'hadir' => 'success',
                'terlambat' => 'warning',
                'izin' => 'info',
                default => 'error'
            })
            ->required();

        return $fields;
    }

    public function rules($item): array
    {
        return [
            'employee_id' => ['required', 'exists:employees,id'],
            'date' => ['required', 'date'],
            'clock_in' => ['required'],
            'status' => ['required', 'in:hadir,terlambat,izin,alpa'],
        ];
    }
    /**
     * @return list<class-string<PageContract>>
     */
    protected function pages(): array
    {
        return [
            AttendanceIndexPage::class,
            AttendanceFormPage::class,
        ];
    }
}
