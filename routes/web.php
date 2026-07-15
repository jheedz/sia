<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AttendanceController;
use App\Http\Controllers\AttendanceReportController;

Route::get('/', fn () => redirect('/admin'));
Route::get('/attendance-kiosk', [AttendanceController::class, 'index'])
    ->name('attendance.kiosk');

Route::post('/attendance-kiosk', [AttendanceController::class, 'process'])
    ->name('attendance.process');

Route::get('/admin/attendance-report/excel', [AttendanceReportController::class, 'exportExcel'])->name('admin.attendance.excel');
Route::get('/admin/attendance-report/individual', [AttendanceReportController::class, 'printIndividual'])->name('admin.attendance.individual');
Route::get('/admin/attendance-report/individual/excel', [AttendanceReportController::class, 'exportIndividualExcel'])->name('admin.attendance.individual.excel');
Route::get('/admin/attendance-report/print', [AttendanceReportController::class, 'print'])->name('admin.attendance.print');