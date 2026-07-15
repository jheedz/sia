<?php

declare(strict_types=1);

namespace App\MoonShine\Pages;

use MoonShine\Core\Pages\Page;
use MoonShine\UI\Components\FormBuilder;
use MoonShine\UI\Fields\Select;
use App\Models\Employee;
use Carbon\Carbon;
use MoonShine\Support\Enums\FormMethod;
use App\Exports\AttendanceExport;
use Maatwebsite\Excel\Facades\Excel;
use MoonShine\UI\Components\ActionButton;

class AttendanceIndividualReportPage extends Page
{
    public function getTitle(): string
    {
        return 'Laporan Absensi Per Karyawan';
    }

    public function components(): array
    {
        $currentYear = (int) date('Y');
        $years = [];
        for ($i = $currentYear; $i >= $currentYear - 3; $i--) {
            $years[$i] = (string) $i;
        }
        $months = [];
        for ($i = 1; $i <= 12; $i++) {
            $months[$i] = Carbon::create()->month($i)->format('F');
        }
        $employeeOptions = Employee::select('id', 'name', 'nik')
                                    ->get()
                                    ->pluck('name_with_nik', 'id')
                                    ->toArray();

        return [
            FormBuilder::make()
                ->method(FormMethod::GET)
                ->fields([
                    Select::make('Pilih Karyawan', 'employee_id')
                        ->options($employeeOptions)
                        ->searchable()
                        ->nullable()
                        ->required(),

                    Select::make('Pilih Bulan', 'month')
                        ->options($months)
                        ->default((string) date('n'))
                        ->required(),

                    Select::make('Pilih Tahun', 'year')
                        ->options($years)
                        ->default((string) $currentYear)
                        ->required(),
                ])
                // Kita ganti tombol submit single dengan tombol bercabang ini:
                ->buttons([
                    ActionButton::make('🖨️ Cetak HTML / PDF', '#')
                        ->customAttributes([
                            'onclick' => "this.closest('form').action='" . route('admin.attendance.individual') . "'; this.closest('form').target='_blank'; this.closest('form').submit(); return false;"
                        ])
                        ->primary(),

                    ActionButton::make('📊 Unduh Excel', '#')
                        ->customAttributes([
                            'onclick' => "this.closest('form').action='" . route('admin.attendance.individual.excel') . "'; this.closest('form').target='_self'; this.closest('form').submit(); return false;"
                        ])
                        ->success(),
                ]),
        ];
    }
}