<?php
declare(strict_types=1);

namespace App\MoonShine\Resources\Registration;

use App\Models\Registration;
use App\Models\Student;
use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\Support\Enums\PageType;
use MoonShine\UI\Components\ActionButton;
use MoonShine\UI\Components\Form;
use MoonShine\UI\Fields\Text;
use MoonShine\UI\Fields\Date;
use MoonShine\UI\Fields\Select;
use MoonShine\UI\Fields\Image;

class RegistrationResource extends ModelResource
{
    protected string $model = Registration::class;

    protected string $title = 'Pendaftaran Siswa Baru';
    protected ?PageType $redirectAfterSave = PageType::INDEX;
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
     * Field untuk Halaman Index / Tabel
     *//**
     * Field untuk Halaman Index / Tabel
     */
    public function indexFields(): array
    {
        return [
            Text::make('No. Reg', 'registration_number')->sortable(),
            Text::make('Nama Calon Siswa', 'name')->sortable(),
            Text::make('Gender', 'gender', fn(Registration $item) => $item->gender === 'L' ? 'Laki-laki' : 'Perempuan'),
            Date::make('Tgl Lahir', 'birth_date')->format('d M Y')->sortable(),
            Text::make('No HP', 'phone'),
            Image::make('Foto', 'foto')
                ->dir('registrations'),

            Select::make('Status', 'status')
                ->options([
                    'pending'  => 'Pending',
                    'verified' => 'Verified',
                    'accepted' => 'Accepted',
                    'rejected' => 'Rejected',
                ])
                ->badge(fn($value) => match($value) {
                    'accepted' => 'success',
                    'verified' => 'info',
                    'pending'  => 'warning',
                    default    => 'error'
                }),
        ];
    }

    /**
     * Field untuk Form Input & Edit
     */
    protected function formFields(): array
    {
        return [
            Text::make('Nama Lengkap', 'name')->required(),
            Select::make('Jenis Kelamin', 'gender')
                ->options(['L' => 'Laki-laki', 'P' => 'Perempuan'])
                ->required(),
            Date::make('Tanggal Lahir', 'birth_date')->required(),
            Text::make('No HP / WA', 'phone'),
            Image::make('Foto', 'foto')->dir('registrations'),
            Select::make('Status Pendaftaran', 'status')
                ->options([
                    'pending'  => 'Pending',
                    'verified' => 'Verified',
                    'accepted' => 'Accepted',
                    'rejected' => 'Rejected',
                ])
                ->default('pending'),
        ];
    }

    /**
     * Field untuk Halaman Detail
     */
    protected function detailFields(): array
    {
        return $this->formFields();
    }
    
    public function rules($item): array
    {
        return [
            'name'       => ['required', 'string', 'max:255'],
            'gender'     => ['required', 'in:L,P'],
            'birth_date' => ['required', 'date'],
            'status'     => ['required', 'in:pending,verified,accepted,rejected'],
        ];
    }
}