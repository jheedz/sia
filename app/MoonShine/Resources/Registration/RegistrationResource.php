<?php
declare(strict_types=1);
namespace App\MoonShine\Resources\Registration; // Tambahkan \Registration

use App\Models\Registration;
use App\Models\Student;
use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\UI\Fields\Text;
use MoonShine\UI\Fields\Date;
use MoonShine\UI\Fields\Select;
use MoonShine\UI\Fields\Image;
use MoonShine\UI\Fields\Textarea;
use MoonShine\Laravel\MoonShineUI;
use MoonShine\Support\Enums\PageType;

class RegistrationResource extends ModelResource
{
    protected string $model = Registration::class;

    protected string $title = 'Pendaftaran Siswa Baru';

    protected ?PageType $redirectAfterSave = PageType::INDEX;

    public function search(): array
    {
        return ['registration_number', 'name', 'phone'];
    }

    public function formFields(): array
    {
        return [
            Text::make('No. Pendaftaran', 'registration_number')
                ->readonly()
                ->placeholder('Otomatis oleh sistem'),

            Text::make('Nama Lengkap', 'name')->required(),

            Select::make('Jenis Kelamin', 'gender')
                ->options(['L' => 'Laki-laki', 'P' => 'Perempuan'])
                ->required(),

            Date::make('Tanggal Lahir', 'birth_date')->required(),

            Text::make('No HP / WA', 'phone'),
            Textarea::make('Alamat', 'address'),
            
            Image::make('Foto', 'foto')
                ->dir('registrations')
                ->allowedExtensions(['jpg', 'jpeg', 'png', 'webp']),

            Select::make('Status Pendaftaran', 'status')
                ->options([
                    'pending'  => 'Pending (Menunggu Verifikasi)',
                    'verified' => 'Terverifikasi',
                    'accepted' => 'Diterima (Proses ke Master Siswa)',
                    'rejected' => 'Ditolak',
                ])
                ->required()
                ->default('pending'),

            Textarea::make('Catatan', 'notes'),
        ];
    }

    public function fields(): array
    {
        return [
            Text::make('No. Reg', 'registration_number')->sortable(),
            Text::make('Nama Calon Siswa', 'name')->sortable(),
            Text::make('JK', 'gender', function ($item) {
                return $item->gender === 'L' ? 'L' : 'P';
            }),
            Date::make('Tgl Lahir', 'birth_date')->format('d M Y'),
            Text::make('No HP', 'phone'),
            
            Select::make('Status', 'status')
                ->options([
                    'pending'  => 'Pending',
                    'verified' => 'Terverifikasi',
                    'accepted' => 'Diterima',
                    'rejected' => 'Ditolak',
                ])
                ->badge(fn($value) => match($value) {
                    'accepted' => 'success',
                    'verified' => 'info',
                    'pending'  => 'warning',
                    default    => 'error'
                }),
        ];
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