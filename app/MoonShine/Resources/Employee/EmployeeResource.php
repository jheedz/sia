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
    public function fields(): array
    {
        return [

            // Input NIK / Nomor Induk Karyawan
            Text::make('NIK / NIP', 'nik')
                ->required()
                ->placeholder('Contoh: EMP2026001')
                ->sortable(),

            // Nama Karyawan
            Text::make('Nama Lengkap', 'name')
                ->required()
                ->sortable()
                ->placeholder('Masukkan nama lengkap...'),

            // Email Karyawan
            Email::make('Email', 'email')
                ->required()
                ->placeholder('alamat@perusahaan.com'),

           BelongsTo::make('Jabatan / Posisi', 'position', resource: PositionResource::class)
                ->placeholder('Pilih Jabatan')
                ->required(),
            
            Select::make('Jenis Kelamin', 'gender')
                        ->options([
                            'Laki-laki' => 'Laki-laki',
                            'Perempuan' => 'Perempuan',
                        ])
                        ->required()
                        ->searchable(),
            Date::make('Tanggal Lahir', 'birthday')
                ->required()
                ->format('d M Y'),
            Date::make('Tanggal Masuk', 'joined_at')
                ->required()
                ->format('d M Y'),
            Text::make('Alamat', 'address')
                ->required()
                ->sortable()
                ->placeholder('Masukkan alamat...'),
            Image::make('Foto Profil', 'photo')
                ->dir('employees') 
                ->allowedExtensions(['jpg', 'jpeg', 'png', 'webp'])
                ->removable(), 
            Switcher::make('Status Aktif', 'is_active')
                ->default(true)
                ->updateOnPreview(),
        ];
    }

    public function rules($item): array
    {
        return [
            'nik' => ['required', 'string', 'unique:employees,nik,' . $item->id],
            'name' => ['required', 'string', 'max:200'],
            'address' => ['required', 'string', 'max:200'],
            'email' => ['required', 'email', 'unique:employees,email,' . $item->id],
            'position' => ['required', 'in:manager,supervisor,staff,intern'],
            'gender' => ['required', 'in:Laki-laki,Perempuan'],
            'photo' => ['nullable', 'image', 'mimes:jpeg,png,jpg,webp', 'max:2048'],
            'joined_at' => ['required', 'date'],
            'birthday' => ['required', 'date'],
            'is_active' => ['boolean'],
        ];
    }
}