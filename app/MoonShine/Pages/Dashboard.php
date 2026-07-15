<?php
namespace App\MoonShine\Pages;

// KOREKSI DI SINI: Gunakan namespace Page yang benar untuk MoonShine v4
use MoonShine\Laravel\Pages\Page; 

use MoonShine\UI\Components\Layout\Grid;
use MoonShine\UI\Components\Layout\Column;
use MoonShine\UI\Components\Metrics\Wrapped\ValueMetric;

use App\Models\Employee;
use App\Models\Attendance;
use App\Models\Student;
use App\Models\Inventory;
use Carbon\Carbon;
class Dashboard extends Page
{
    /**
     * @return array<string, string>
     */
    public function getBreadcrumbs(): array
    {
        return [
            '#' => $this->getTitle()
        ];
    }

    public function getTitle(): string
    {
        return $this->title ?: 'Dashboard Utama';
    }

    /**
     * Di sini tempat kita merancang isi komponen Dashboard
     */
    public function components(): array
    {
        $terlambatHariIni = Attendance::where('date', Carbon::today())
            ->where('status', 'terlambat')
            ->count();

        return [
            Grid::make([
                Column::make([
                    ValueMetric::make('Jumlah Pegawai')
                        ->value(Employee::count())
                        ->icon('users')
                ])->columnSpan(6),

                Column::make([
                    ValueMetric::make('Jumlah Murid')
                        ->value(Student::count())
                        ->icon('academic-cap')
                ])->columnSpan(6),

                Column::make([
                    ValueMetric::make('Total Aset Sekolah')
                        ->value(Inventory::count())
                        ->icon('briefcase')
                ])->columnSpan(6),

                Column::make([
                    ValueMetric::make('Terlambat Hari Ini')
                        ->value($terlambatHariIni)
                        ->icon('clock')
                ])->columnSpan(6),
            ])
        ];
    }
}