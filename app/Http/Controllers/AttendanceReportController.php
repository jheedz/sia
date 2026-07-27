<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Employee;
use App\Models\Holiday; // 🟢 1. Import Model Holiday
use Carbon\Carbon;
use App\Exports\AttendanceExport;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\AttendanceIndividualExport;

class AttendanceReportController extends Controller
{
    public function print(Request $request)
    {
        $request->validate([
            'month' => 'required|integer|between:1,12',
            'year'  => 'required|integer',
        ]);

        $month = $request->month;
        $year  = $request->year;
        
        $startDate = Carbon::createFromDate($year, $month, 1)->startOfMonth();
        $endDate   = Carbon::createFromDate($year, $month, 1)->endOfMonth();

        // 🟢 2. Ambil data libur nasional/internal di rentang bulan tersebut
        $holidays = Holiday::whereDate('date', '>=', $startDate->format('Y-m-d'))
            ->whereDate('date', '<=', $endDate->format('Y-m-d'))
            ->pluck('description', 'date')
            ->toArray();

        // Ambil semua karyawan beserta data absennya di bulan tersebut
        $employees = Employee::with([
            'position', 
            'attendances' => function($query) use ($startDate, $endDate) {
                $query->whereDate('date', '>=', $startDate->format('Y-m-d'))
                      ->whereDate('date', '<=', $endDate->format('Y-m-d'));
            }]
        )->get();

        $monthName = $startDate->isoFormat('MMMM YYYY');

        // 🟢 3. Oper $holidays ke View
        return view('reports.attendance-print', compact(
            'employees', 
            'monthName', 
            'startDate', 
            'endDate', 
            'holidays'
        ));
    }

    public function printIndividual(Request $request)
    {
        $request->validate([
            'employee_id' => 'required|exists:employees,id',
            'month'       => 'required|integer|between:1,12',
            'year'        => 'required|integer',
        ]);

        $month = $request->month;
        $year  = $request->year;
        
        $startDate = Carbon::createFromDate($year, $month, 1)->startOfMonth();
        $endDate   = Carbon::createFromDate($year, $month, 1)->endOfMonth();

        // 🟢 2. Ambil data libur di rentang bulan tersebut
        $holidays = Holiday::whereDate('date', '>=', $startDate->format('Y-m-d'))
            ->whereDate('date', '<=', $endDate->format('Y-m-d'))
            ->pluck('description', 'date')
            ->toArray();

        // 1. GENERATE DAFTAR TANGGAL UTUH (1 s/d Akhir Bulan)
        $calendarRange = \Carbon\CarbonPeriod::create($startDate, $endDate);

        $employee = Employee::with(['position', 'attendances' => function($query) use ($startDate, $endDate) {
            $query->whereBetween('date', [$startDate->format('Y-m-d'), $endDate->format('Y-m-d')])->orderBy('date', 'asc');
        }])->findOrFail($request->employee_id);

        // 2. RE-MAP ABSENSI MENGGUNAKAN TANGGAL SEBAGAI KEY
        $attendances = $employee->attendances->keyBy(function($item) {
            // Pastikan format date-nya string Y-m-d
            return is_string($item->date) ? $item->date : $item->date->format('Y-m-d');
        });

        $monthName = $startDate->isoFormat('MMMM YYYY');

        // 3. LEMPAR DATA KE VIEW (Sertakan $holidays)
        return view('reports.attendance-individual-print', compact(
            'employee', 
            'monthName', 
            'startDate', 
            'endDate',
            'calendarRange',
            'attendances',
            'holidays' // 🟢 3. Oper $holidays ke View Individu
        ));
    }

    public function exportExcel(Request $request)
    {
        $request->validate([
            'month' => 'required|integer|between:1,12',
            'year'  => 'required|integer',
        ]);

        $namaBulan = Carbon::createFromDate($request->year, $request->month, 1)->isoFormat('MMMM-YYYY');
        $namaFile  = "Laporan_Absensi_{$namaBulan}.xlsx";

        return Excel::download(new AttendanceExport($request->month, $request->year), $namaFile);
    }

    public function exportIndividualExcel(Request $request)
    {
        $request->validate([
            'employee_id' => 'required|exists:employees,id',
            'month'       => 'required|integer|between:1,12',
            'year'        => 'required|integer',
        ]);

        $employee  = Employee::findOrFail($request->employee_id);
        $namaBulan = Carbon::createFromDate($request->year, $request->month, 1)->isoFormat('MMMM-YYYY');
        $namaFile  = "Laporan_Absen_" . str_replace(' ', '_', $employee->name) . "_{$namaBulan}.xlsx";

        return Excel::download(new AttendanceIndividualExport($request->employee_id, $request->month, $request->year), $namaFile);
    }
}