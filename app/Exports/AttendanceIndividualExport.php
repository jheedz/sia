<?php

namespace App\Exports;

use App\Models\Employee;
use Carbon\Carbon;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithCustomStartCell;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class AttendanceIndividualExport implements FromCollection, WithHeadings, WithMapping, ShouldAutoSize, WithCustomStartCell, WithStyles
{
    protected $employeeId;
    protected $month;
    protected $year;
    protected $startDate;
    protected $endDate;
    protected $employee;
    protected $rowNumber = 0;

    public function __construct($employeeId, $month, $year)
    {
        $this->employeeId = $employeeId;
        $this->month = $month;
        $this->year = $year;
        $this->startDate = Carbon::createFromDate($year, $month, 1)->startOfMonth();
        $this->endDate = Carbon::createFromDate($year, $month, 1)->endOfMonth();
        
        // Ambil data karyawan langsung saat inisialisasi untuk kita tulis di header Excel nanti
        $this->employee = Employee::with(['position', 'attendances' => function($query) {
            $query->whereBetween('date', [$this->startDate, $this->endDate])->orderBy('date', 'asc');
        }])->findOrFail($employeeId);
    }

    /**
     * Karena ada baris biodata di atas tabel, kita minta tabel utama dimulai dari baris ke-8
     */
    public function startCell(): string
    {
        return 'A8';
    }

    /**
     * Mengembalikan koleksi data absensi si karyawan untuk di-loop di tabel bawah
     */
    public function collection()
    {
        return $this->employee->attendances;
    }

    /**
     * Judul Kolom Tabel (Mulai di Baris ke-8)
     */
    public function headings(): array
    {
        return [
            'No',
            'Tanggal',
            'Jam Masuk',
            'Jam Keluar',
            'Durasi Kerja',
            'Status',
            'Keterangan',
        ];
    }

    /**
     * Mapping data per baris absen harian
     */
    public function map($attendance): array
    {
        $this->rowNumber++;

        return [
            $this->rowNumber,
            $attendance->date->isoFormat('dddd, D MMMM YYYY'),
            $attendance->clock_in ? $attendance->clock_in->format('H:i') : '-',
            $attendance->clock_out ? $attendance->clock_out->format('H:i') : '-',
            $attendance->working_hours > 0 ? $attendance->working_hours . ' Jam' : '-',
            strtoupper($attendance->status),
            $attendance->notes ?? '-',
        ];
    }

    /**
     * Styling kustom untuk menyisipkan BIODATA di baris paling atas (A1 sampai A6)
     */
    public function styles(Worksheet $sheet)
    {
        // Tulis Judul Laporan
        $sheet->setCellValue('A1', 'LAPORAN REKAP ABSENSI INDIVIDU');
        $sheet->mergeCells('A1:G1');
        
        // Tulis Detail Biodata
        $sheet->setCellValue('A3', 'Nama Karyawan :');
        $sheet->setCellValue('B3', $this->employee->name);
        
        $sheet->setCellValue('A4', 'Jabatan :');
        $sheet->setCellValue('B4', $this->employee->position?->name ?? '-');
        
        $sheet->setCellValue('A5', 'Periode Bulan :');
        $sheet->setCellValue('B5', $this->startDate->isoFormat('MMMM YYYY'));
        
        $sheet->setCellValue('A6', 'Total Kerja :');
        $sheet->setCellValue('B6', $this->employee->totalWorkingHours($this->startDate, $this->endDate) . ' Jam');

        // Beri style tebal (Bold) untuk judul dan label biodata
        return [
            1 => ['font' => ['bold' => true, 'size' => 14]],
            3 => ['font' => ['bold' => true]],
            4 => ['font' => ['bold' => true]],
            5 => ['font' => ['bold' => true]],
            6 => ['font' => ['bold' => true]],
            8 => ['font' => ['bold' => true]], // Header tabel utama
        ];
    }
}