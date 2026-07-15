<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\Student;

use App\Models\Student;
use App\MoonShine\Resources\Student\Pages\StudentIndexPage;
use App\MoonShine\Resources\Student\Pages\StudentFormPage;
use App\MoonShine\Resources\Student\Pages\StudentDetailPage;
use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\Contracts\Core\PageContract;
use MoonShine\Support\Enums\PageType;
use MoonShine\UI\Fields\Text;
use MoonShine\UI\Fields\Date;
use MoonShine\UI\Fields\Select;
use MoonShine\UI\Fields\Image;

/**
 * @extends ModelResource<Student, StudentIndexPage, StudentFormPage, StudentDetailPage>
 */
class StudentResource extends ModelResource
{
    protected string $model = Student::class;

    protected string $title = 'Data Siswa';
    
    protected ?PageType $redirectAfterSave = PageType::INDEX;

    public function search(): array
    {
        return ['nisn', 'name', 'phone'];
    }

    /**
     * TAMPILAN FORM INPUT / EDIT
     */
    public function formFields(): array
    {
        return [
            Text::make('NISN / No Induk', 'nisn')
                ->required()
                ->placeholder('Contoh: 0012345678'),

            Text::make('Nama Lengkap', 'name')
                ->required(),

            Select::make('Jenis Kelamin', 'gender')
                ->options([
                    'L' => 'Laki-laki',
                    'P' => 'Perempuan',
                ])
                ->required(),

            // Input Tanggal Lahir Reaktif untuk hitung umur seketika
            Date::make('Tanggal Lahir', 'birth_date')
                ->required(),

            Text::make('No HP / WhatsApp', 'phone')
                ->placeholder('Contoh: 08123456789'),
            
            Image::make('Foto Profil', 'foto')
                ->dir('students') 
                ->allowedExtensions(['jpg', 'jpeg', 'png', 'webp'])
                ->removable(), 
            Select::make('Status Keaktifan', 'status')
                ->options([
                    'aktif' => 'Aktif',
                    'lulus' => 'Lulus',
                    'pindah' => 'Pindah Sekolah',
                    'keluar' => 'Keluar',
                ])
                ->required()
                ->default('aktif'),
        ];
    }

    /**
     * TAMPILAN HALAMAN INDEX (TABEL UTAMA) & DETAIL
     */
    public function fields(): array
    {
        return [
            Text::make('NISN', 'nisn')->sortable(),
            Text::make('Nama Siswa', 'name')->sortable(),
            
            Text::make('JK', 'gender', function($item) {
                return $item->gender === 'L' ? 'Laki-laki' : 'Perempuan';
            })->sortable(),

            Date::make('Tanggal Lahir', 'birth_date')
                ->format('d M Y')
                ->sortable(),

            // Tampilkan hitungan umur langsung di tabel index lewat data model
            Text::make('Umur', 'age', function($item) {
                return $item->birth_date ? \Carbon\Carbon::parse($item->birth_date)->age . ' Thn' : '-';
            }),

            Text::make('No HP', 'phone'),
            Image::make('Foto Profil', 'foto')
                ->dir('students') 
                ->allowedExtensions(['jpg', 'jpeg', 'png', 'webp'])
                ->removable(), 

            Select::make('Status', 'status')
                ->options([
                    'aktif' => 'Aktif',
                    'lulus' => 'Lulus',
                    'pindah' => 'Pindah',
                    'keluar' => 'Keluar',
                ])
                ->badge(fn($value) => match($value) {
                    'aktif' => 'success',
                    'lulus' => 'info',
                    'pindah' => 'warning',
                    default => 'error'
                }),
        ];
    }

    public function rules($item): array
    {
        return [
            'nisn' => ['required', 'string', 'unique:students,nisn,' . ($item->id ?? '')],
            'name' => ['required', 'string', 'max:255'],
            'gender' => ['required', 'in:L,P'],
            'birth_date' => ['required', 'date'],
            'status' => ['required', 'in:aktif,lulus,pindah,keluar'],
        ];
    }

    protected function pages(): array
    {
        return [
            StudentIndexPage::class,
            StudentFormPage::class,
            StudentDetailPage::class,
        ];
    }
}