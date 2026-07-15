<?php

namespace App\Http\Controllers;

use App\Services\AttendanceService;
use Illuminate\Http\Request;

class AttendanceController extends Controller
{
    public function index()
    {
        return view('attendance.kiosk');
    }

    public function process(Request $request, AttendanceService $attendanceService)
    {
        $request->validate([
            'nik' => ['required', 'string'],
        ]);

        $result = $attendanceService->process($request->nik);
        // logger()->info('Hasil pencarian NIK ('. $request->nik .'): ', ['found' => $result]);
        return redirect()
            ->route('attendance.kiosk')
            ->with($result);
    }
}