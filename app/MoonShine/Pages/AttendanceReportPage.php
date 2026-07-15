<?php

declare(strict_types=1);

namespace App\MoonShine\Pages;

use MoonShine\Core\Pages\Page;
use MoonShine\UI\Components\Components;
use MoonShine\UI\Components\FormBuilder;
use MoonShine\UI\Fields\Select;
use Carbon\Carbon;
use MoonShine\Support\Enums\FormMethod;
use MoonShine\UI\Components\ActionButton;

class AttendanceReportPage extends Page
{
    public function getTitle(): string
    {
        return $this->title ?: 'Cetak Laporan Absensi';
    }

    /**
     * Komponen komponen yang tampil di dalam Halaman Kustom
     */
    public function components(): array
    {
        // Menyusun daftar tahun (3 tahun terakhir hingga tahun ini)
        $currentYear = (int) date('Y');
        $years = [];
        $months = [];
        for ($i = $currentYear; $i >= $currentYear - 5; $i--) {
            $years[$i] = (string) $i;
        }
        for ($i = 1; $i <= 12; $i++) {
            $months[$i] = Carbon::create()->month($i)->format('F');
        }
        return [
            FormBuilder::make()
                ->method(FormMethod::GET)
                ->fields([
                    Select::make('Pilih Bulan', 'month')
                        ->options($months)
                        ->default((string) date('n'))
                        ->required(),

                    Select::make('Pilih Tahun', 'year')
                        ->options($years)
                        ->default((string) $currentYear)
                        ->required(),
                ])
                ->buttons([
                    ActionButton::make('🖨️ Cetak HTML / PDF', '#')
                        ->customAttributes([
                            'onclick' => "this.closest('form').action='" . route('admin.attendance.print') . "'; this.closest('form').target='_blank'; this.closest('form').submit(); return false;"
                        ])
                        ->primary(),

                    ActionButton::make('📊 Unduh Excel', '#')
                        ->customAttributes([
                            'onclick' => "this.closest('form').action='" . route('admin.attendance.excel') . "'; this.closest('form').target='_self'; this.closest('form').submit(); return false;"
                        ])
                        ->success(),
                ]),
        ];
    }
}