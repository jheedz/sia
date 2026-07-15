<?php

namespace App\Exports;

use App\Models\Employee;
use Carbon\Carbon;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class AttendanceExport implements FromCollection, WithHeadings, WithMapping, ShouldAutoSize
{
    protected $month;
    protected $year;
    protected $startDate;
    protected $endDate;
    protected $rowNumber = 0;

    public function __construct($month, $year)
    {
        $this->month = $month;
        $this->year = $year;
        $this->startDate = Carbon::createFromDate($year, $month, 1)->startOfMonth();
        $this->endDate = Carbon::createFromDate($year, $month, 1)->endOfMonth();
    }

    /**
     * Ambil data dari database
     */
    public function collection()
    {
        return Employee::with(['position', 'attendances' => function($query) {
            $query->whereBetween('date', [$this->startDate, $this->endDate]);
        }])->get();
    }

    /**
     * Judul Kolom (Header) Excel
     */
    public function headings(): array
    {
        return [
            'No',
            'Nama Karyawan',
            'Jabatan',
            'Total Hadir (Hari)',
            'Total Jam Kerja (Jam)',
        ];
    }

    /**
     * Mapping data dari Eloquent ke Baris Excel
     */
    public function map($employee): array
    {
        $this->rowNumber++;

        return [
            $this->rowNumber,
            $employee->name,
            $employee->position?->name ?? '-',
            $employee->attendances->where('status', 'hadir')->count() . ' Hari',
            $employee->totalWorkingHours($this->startDate, $this->endDate) . ' Jam',
        ];
    }
}