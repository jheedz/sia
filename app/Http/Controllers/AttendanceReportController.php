<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Employee;
use App\Models\Attendance;
use Carbon\Carbon;
use MoonShine\Support\Enums\FormMethod;
use App\Exports\AttendanceExport;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\AttendanceIndividualExport;

class AttendanceReportController extends Controller
{
    public function print(Request $request)
    {
        $request->validate([
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
        ]);

        $month = $request->month;
        $year = $request->year;
        
        $startDate = Carbon::createFromDate($year, $month, 1)->startOfMonth();
        $endDate = Carbon::createFromDate($year, $month, 1)->endOfMonth();

        // Ambil semua karyawan beserta data absennya di bulan tersebut
        $employees = Employee::with([
            'position', 
            'attendances' => function($query) use ($startDate, $endDate) {
                $query->whereBetween('date', [$startDate, $endDate]);
            }]
        )->get();

        $monthName = $startDate->isoFormat('MMMM YYYY');

        return view('reports.attendance-print', compact('employees', 'monthName', 'startDate', 'endDate'));
    }
    public function exportExcel(Request $request)
    {
        $request->validate([
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
        ]);

        $namaBulan = Carbon::createFromDate($request->year, $request->month, 1)->isoFormat('MMMM-YYYY');
        $namaFile = "Laporan_Absensi_{$namaBulan}.xlsx";

        // Memicu download file Excel otomatis
        return Excel::download(new AttendanceExport($request->month, $request->year), $namaFile);
    }
    public function printIndividual(Request $request)
    {
        $request->validate([
            'employee_id' => 'required|exists:employees,id',
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
        ]);

        $month = $request->month;
        $year = $request->year;
        
        $startDate = Carbon::createFromDate($year, $month, 1)->startOfMonth();
        $endDate = Carbon::createFromDate($year, $month, 1)->endOfMonth();

        // 1. GENERATE DAFTAR TANGGAL UTUH (1 s/d Akhir Bulan)
        // Kita buat list tanggal lengkap di memori menggunakan CarbonPeriod
        $calendarRange = \Carbon\CarbonPeriod::create($startDate, $endDate);

        $employee = Employee::with(['position', 'attendances' => function($query) use ($startDate, $endDate) {
            $query->whereBetween('date', [$startDate, $endDate])->orderBy('date', 'asc');
        }])->findOrFail($request->employee_id);

        // 2. RE-MAP ABSENSI MENGGUNAKAN TANGGAL SEBAGAI KEY
        // Trik ini merapikan data absen agar saat dicari di View tinggal panggil: $attendances->get('2026-07-14')
        $attendances = $employee->attendances->keyBy(function($item) {
            return $item->date->format('Y-m-d');
        });

        $monthName = $startDate->isoFormat('MMMM YYYY');

        // 3. LEMPAR DATA KE VIEW
        // Kita tambahkan variabel 'calendarRange' dan 'attendances' ke compact
        return view('reports.attendance-individual-print', compact(
            'employee', 
            'monthName', 
            'startDate', 
            'endDate',
            'calendarRange',
            'attendances'
        ));
    }
    public function exportIndividualExcel(Request $request)
    {
        $request->validate([
            'employee_id' => 'required|exists:employees,id',
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
        ]);

        $employee = Employee::findOrFail($request->employee_id);
        $namaBulan = Carbon::createFromDate($request->year, $request->month, 1)->isoFormat('MMMM-YYYY');
        
        // Format nama file: Laporan_Absen_Andi_Juli-2026.xlsx
        $namaFile = "Laporan_Absen_" . str_replace(' ', '_', $employee->name) . "_{$namaBulan}.xlsx";

        return Excel::download(new AttendanceIndividualExport($request->employee_id, $request->month, $request->year), $namaFile);
    }
}