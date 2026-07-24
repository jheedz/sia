<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\Employee;

use Illuminate\Database\Eloquent\Model;
use App\Models\Employee;
use App\MoonShine\Resources\Employee\Pages\EmployeeIndexPage;
use App\MoonShine\Resources\Employee\Pages\EmployeeFormPage;
use App\MoonShine\Resources\Employee\Pages\EmployeeDetailPage;
use MoonShine\UI\Fields\Image;
use MoonShine\Laravel\Fields\Relationships\BelongsTo;
use App\MoonShine\Resources\Position\PositionResource;

// Import Fields MoonShine v3
use MoonShine\UI\Fields\ID;
use MoonShine\UI\Fields\Text;
use MoonShine\UI\Fields\Email;
use MoonShine\UI\Fields\Select;
use MoonShine\UI\Fields\Date;
use MoonShine\UI\Fields\Switcher;

// Layouts
use MoonShine\UI\Components\Layout\Grid;
use MoonShine\UI\Components\Layout\Column;
use MoonShine\UI\Components\Layout\Box;

// Import Core & Support MoonShine v3 yang dibutuhkan
use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\Contracts\Core\PageContract;
use MoonShine\Support\Enums\PageType;
use MoonShine\Support\Enums\Action;   
use MoonShine\Support\ListOf;         

/**
 * @extends ModelResource<Employee, EmployeeIndexPage, EmployeeFormPage, EmployeeDetailPage>
 */
class EmployeeResource extends ModelResource
{
    protected string $model = Employee::class;
    protected string $title = 'Employees'; 
    protected ?PageType $redirectAfterSave = PageType::INDEX;
    protected string $sortColumn    = 'nik';
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

    /**
     * @return list<class-string<PageContract>>
     */
    protected function pages(): array
    {
        return [
            EmployeeIndexPage::class,
            EmployeeFormPage::class,
            EmployeeDetailPage::class,
        ];
    }
    public function search(): array
    {
        return ['nik', 'name', 'email'];
    }
    public function indexFields(): iterable
    {
        return [
            Text::make('NIK', 'nik')->sortable(),
            Text::make('Nama', 'name')->sortable(),
            Text::make('No. HP', 'phone'),
            Text::make('Email', 'email'),
            BelongsTo::make('Jabatan', 'position', 'name'),
            Select::make('Status Kerja', 'employment_status')
                ->options([
                    'permanent'  => 'Tetap',
                    'contract'   => 'Kontrak',
                    'probation'  => 'Probation',
                    'internship' => 'Magang',
                ])
                ->badge(fn($status) => match($status) {
                    'permanent'  => 'success',  // Hijau
                    'contract'   => 'warning',  // Kuning
                    'probation'  => 'info',     // Biru
                    'internship' => 'gray',     // Abu-abu
                    default      => 'default'
                }),
            Image::make('Foto', 'photo'),
            Switcher::make('Status Aktif', 'is_active')
                ->default(true)
                ->updateOnPreview(),
        ];
    }
    public function fields(): array
    {
        return [
            Grid::make([
                // 🔴 KOLOM KIRI: Informasi Personal & Kontak (50% / columnSpan 6)
                Column::make([
                    Box::make('Informasi Personal', [
                        // Nama Karyawan
                        Text::make('Nama Lengkap', 'name')
                            ->required()
                            ->sortable()
                            ->placeholder('Masukkan nama lengkap...'),

                        // Email Karyawan
                        Email::make('Email', 'email')
                            ->required()
                            ->placeholder('alamat@perusahaan.com'),

                        Text::make('No. Telepon', 'phone')
                            ->placeholder('Contoh: 08123456789')
                            ->nullable(),

                        Select::make('Jenis Kelamin', 'gender')
                            ->options([
                                'Laki-laki' => 'Laki-laki',
                                'Perempuan' => 'Perempuan',
                            ])
                            ->required()
                            ->searchable(),

                        Select::make('Golongan Darah', 'blood_type')
                            ->options([
                                'A'  => 'A',
                                'B'  => 'B',
                                'AB' => 'AB',
                                'O'  => 'O',
                            ])
                            ->searchable(),

                        Select::make('Agama', 'religion')
                            ->placeholder('Pilih Agama')
                            ->options([
                                'Islam'  => 'Islam',
                                'Kristen'  => 'Kristen',
                                'Katolik' => 'Katolik',
                                'Hindu'  => 'Hindu',
                                'Konghucu'  => 'Konghucu',
                            ])
                            ->searchable(),

                        Date::make('Tanggal Lahir', 'birthday')
                            ->required()
                            ->format('d M Y'),

                        Text::make('Alamat', 'address')
                            ->required()
                            ->sortable()
                            ->placeholder('Masukkan alamat...'),
                    ]),
                ])->columnSpan(6),

                // 🟢 KOLOM KANAN: Informasi Pekerjaan & Foto (50% / columnSpan 6)
                Column::make([
                    Box::make('Informasi Kepegawaian', [
                        // Input NIK / Nomor Induk Karyawan
                        Text::make('NIK / NIP', 'nik')
                            ->required()
                            ->placeholder('Contoh: EMP2026001')
                            ->sortable(),
                        Image::make('Foto Profil', 'photo')
                            ->dir('employees') 
                            ->allowedExtensions(['jpg', 'jpeg', 'png', 'webp'])
                            ->removable(),
                        BelongsTo::make('Jabatan / Posisi', 'position', resource: PositionResource::class)
                            ->placeholder('Pilih Jabatan')
                            ->required(),

                        Select::make('Status Kerja', 'employment_status')
                            ->options([
                                'Permanent'  => 'Tetap',
                                'Contract'   => 'Kontrak',
                                'Probation'  => 'Probation',
                                'Internship' => 'Magang',
                            ]),
                        Date::make('Tanggal Masuk', 'joined_at')
                            ->required()
                            ->format('d M Y'),
                        Switcher::make('Status Aktif', 'is_active')
                            ->default(true)
                            ->updateOnPreview(),
                    ]),
                ])->columnSpan(6),
            ])
        ];
    }

    public function rules($item): array
    {
        return [
            'nik' => ['required', 'string', 'unique:employees,nik,' . $item->id],
            'name' => ['required', 'string', 'max:200'],
            'address' => ['required', 'string', 'max:200'],
            'email' => ['required', 'email', 'unique:employees,email,' . $item->id],
            'gender' => ['required', 'in:Laki-laki,Perempuan'],
            'photo' => ['nullable', 'image', 'mimes:jpeg,png,jpg,webp', 'max:2048'],
            'joined_at' => ['required', 'date'],
            'birthday' => ['required', 'date'],
            'is_active' => ['boolean'],
        ];
    }
}