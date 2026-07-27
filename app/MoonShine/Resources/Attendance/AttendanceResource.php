<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\Attendance;

use Illuminate\Database\Eloquent\Model;
use App\Models\Attendance;
use App\MoonShine\Resources\Attendance\Pages\AttendanceIndexPage;
use App\MoonShine\Resources\Attendance\Pages\AttendanceFormPage;
use App\MoonShine\Resources\Attendance\Pages\AttendanceDetailPage;
use MoonShine\Laravel\Fields\Relationships\BelongsTo;
use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\Contracts\Core\PageContract;
use MoonShine\Support\Enums\PageType;
use MoonShine\UI\Fields\Text;
use MoonShine\UI\Fields\Date;
use MoonShine\UI\Fields\Select;
use MoonShine\UI\Fields\DateRange;
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
    public function filters(): array
    {
        return [
            // 1. Filter Nama Karyawan (Dropdown / Searchable)
            BelongsTo::make('Karyawan', 'employee', fn($item) => $item->name)
                ->nullable()
                ->searchable(),

            // 2. Filter Berdasarkan Range Tanggal Absensi
            DateRange::make('Rentang Tanggal', 'date')
            ->nullable(),
        ];
    }
    public function search(): array
    {
        return ['employee.name', 'status'];
    }
    
    /**
     * 🟢 FORM FIELDS (Dipakai saat Tambah & Edit Data)
     */
    public function formFields(): array
    {
        return [
            BelongsTo::make('Karyawan', 'employee', fn($item) => $item->name)
                ->searchable()
                ->required(),

            Date::make('Tanggal', 'date')
                ->default(now()->toDateString()) 
                ->required()
                ->format('Y-m-d'),

            Text::make('Jam Masuk', 'clock_in')
                ->setAttribute('type', 'time')
                ->changeFill(static function ($item) {
                    // Jika Tambah Data baru -> nilai default jam sekarang
                    // Jika Edit Data -> ubah H:i:s dari DB menjadi H:i
                    if (!$item->exists) {
                        return now()->format('H:i');
                    }
                    return $item->clock_in ? date('H:i', strtotime((string) $item->clock_in)) : null;
                })
                ->required()
                ->onApply(function ($item, $value) {
                    $item->clock_in = $value ? date('H:i:s', strtotime((string) $value)) : null;
                    return $item;
                }),

            Text::make('Jam Pulang', 'clock_out')
                ->setAttribute('type', 'time')
                ->changeFill(static function ($item) {
                    if (!$item->exists) {
                        return null;
                    }
                    return $item->clock_out ? date('H:i', strtotime((string) $item->clock_out)) : null;
                })
                ->onApply(function ($item, $value) {
                    $item->clock_out = $value ? date('H:i:s', strtotime((string) $value)) : null;
                    return $item;
                }),

            Select::make('Status', 'status')
                ->options([
                    'hadir'     => 'Hadir tepat waktu',
                    'terlambat' => 'Terlambat',
                    'izin'      => 'Izin / Sakit',
                    'alpa'      => 'Alpa / Tanpa Keterangan',
                ])
                ->default('hadir')
                ->required(),
        ];
    }

    /**
     * 🟢 INDEX FIELDS (Dipakai saat Menampilkan Tabel Utama)
     */
    public function fields(): array
    {
        return [
            BelongsTo::make('Karyawan', 'employee', fn($item) => $item->name)
                ->sortable(),
            BelongsTo::make('Posisi', 'employee', fn($item) => $item->position->name ?? '-')
                ->sortable(),

            Date::make('Tanggal', 'date')
                ->sortable()
                ->format('d M Y'),
            Text::make('Jam Masuk', 'clock_in', static fn($item) => $item->clock_in ? date('H:i', strtotime((string) $item->clock_in)) : '-'),

            Text::make('Jam Pulang', 'clock_out', static fn($item) => $item->clock_out ? date('H:i', strtotime((string) $item->clock_out)) : '-'),

            Text::make('Total Jam Kerja', 'total_hours', function($item) {
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
            }),

            Select::make('Status', 'status')
                ->options([
                    'hadir'     => 'Hadir tepat waktu',
                    'terlambat' => 'Terlambat',
                    'izin'      => 'Izin / Sakit',
                    'alpa'      => 'Alpa / Tanpa Keterangan',
                ])
                ->badge(fn($value) => match($value) {
                    'hadir'     => 'success',
                    'terlambat' => 'warning',
                    'izin'      => 'info',
                    default     => 'error'
                }),
        ];

    }

    public function rules($item): array
    {
        return [
            'employee_id' => ['required', 'exists:employees,id'],
            'date'        => ['required', 'date'],
            'clock_in'    => ['required'],
            'status'      => ['required', 'in:hadir,terlambat,izin,alpa'],
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