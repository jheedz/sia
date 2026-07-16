<?php

namespace App\Exports;

use App\Models\Employee;
use Carbon\Carbon;
use Carbon\CarbonPeriod;
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
    protected $attendancesMap; // Tempat menampung data absen dengan key tanggal
    protected $rowNumber = 0;

    public function __construct($employeeId, $month, $year)
    {
        $this->employeeId = $employeeId;
        $this->month = $month;
        $this->year = $year;
        $this->startDate = Carbon::createFromDate($year, $month, 1)->startOfMonth();
        $this->endDate = Carbon::createFromDate($year, $month, 1)->endOfMonth();
        
        // Ambil data karyawan langsung saat inisialisasi
        $this->employee = Employee::with(['position', 'attendances' => function($query) {
            $query->whereBetween('date', [$this->startDate, $this->endDate]);
        }])->findOrFail($employeeId);

        // KUNCI: Remap data absensi agar mudah & cepat dicari berdasarkan string tanggal 'Y-m-d'
        $this->attendancesMap = $this->employee->attendances->keyBy(function($item) {
            return $item->date->format('Y-m-d');
        });
    }

    public function startCell(): string
    {
        return 'A8';
    }

    /**
     * KOREKSI DI SINI:
     * Kita tidak me-return data absen dari DB, melainkan me-return 
     * koleksi tanggal utuh (Kalender) dari tanggal 1 sampai akhir bulan.
     */
    public function collection()
    {
        $period = CarbonPeriod::create($this->startDate, $this->endDate);
        
        // Ubah period menjadi Laravel Collection agar bisa dibaca oleh FromCollection
        return collect($period);
    }

    public function headings(): array
    {
        return [
            'No',
            'Hari', // Tambah kolom hari biar makin informatif
            'Tanggal',
            'Jam Masuk',
            'Jam Keluar',
            'Durasi Kerja',
            'Status',
        ];
    }

    /**
     * KOREKSI DI SINI:
     * Karena yang di-loop di collection() adalah objek Tanggal (Carbon),
     * maka parameter $date di sini adalah setiap tanggal dari tanggal 1 s/d akhir bulan.
     */
    public function map($date): array
    {
        $this->rowNumber++;
        $formattedDate = $date->format('Y-m-d');

        // Cari apakah ada data absen di tanggal ini
        $attendance = $this->attendancesMap->get($formattedDate);
        $isWeekend = $date->isWeekend();

        // 1. KONDISI JIKA ADA ABSENNYA
        if ($attendance) {
            return [
                $this->rowNumber,
                $date->translatedFormat('l'), // Nama hari (Senin, Selasa...)
                $date->format('d-m-Y'),
                $attendance->clock_in ? $attendance->clock_in->format('H:i') : '-',
                $attendance->clock_out ? $attendance->clock_out->format('H:i') : '-',
                $attendance->working_hours > 0 ? $attendance->working_hours . ' Jam' : '-',
                strtoupper($attendance->status),
            ];
        } 
        
        // 2. KONDISI JIKA TIDAK ADA ABSEN & MEMANG HARI LIBUR SABTU/MINGGU
        if ($isWeekend) {
            return [
                $this->rowNumber,
                $date->translatedFormat('l'),
                $date->format('d-m-Y'),
                '-',
                '-',
                '-',
                'LIBUR',
            ];
        }

        // 3. KONDISI JIKA HARI KERJA BIASA TAPI KARYAWAN MANGKIR (TIDAK ABSEN)
        return [
            $this->rowNumber,
            $date->translatedFormat('l'),
            $date->format('d-m-Y'),
            '-',
            '-',
            '-',
            'ALPHA',
        ];
    }

    public function styles(Worksheet $sheet)
    {
        $sheet->setCellValue('A1', 'LAPORAN REKAP ABSENSI INDIVIDU');
        $sheet->mergeCells('A1:G1');
        
        $sheet->setCellValue('A3', 'Nama Karyawan :');
        $sheet->setCellValue('B3', $this->employee->name);
        
        $sheet->setCellValue('A4', 'Jabatan :');
        $sheet->setCellValue('B4', $this->employee->position?->name ?? '-');
        
        $sheet->setCellValue('A5', 'Periode Bulan :');
        $sheet->setCellValue('B5', $this->startDate->isoFormat('MMMM YYYY'));
        
        $sheet->setCellValue('A6', 'Total Kerja :');
        $sheet->setCellValue('B6', $this->employee->totalWorkingHours($this->startDate, $this->endDate) . ' Jam');

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