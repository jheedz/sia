<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AttendanceController;
use App\Http\Controllers\AttendanceReportController;

Route::get('/', fn () => redirect('/admin'));
Route::get('/attendance-kiosk', [AttendanceController::class, 'index'])->name('attendance.kiosk');
Route::post('/attendance-kiosk', [AttendanceController::class, 'process'])->name('attendance.process');

Route::prefix('admin/attendance-report')->name('admin.attendance.')->group(function () {
    Route::get('/print', [AttendanceReportController::class, 'print'])->name('print');
    Route::get('/excel', [AttendanceReportController::class, 'exportExcel'])->name('excel');
    Route::get('/individual', [AttendanceReportController::class, 'printIndividual'])->name('individual');
    Route::get('/individual/excel', [AttendanceReportController::class, 'exportIndividualExcel'])->name('individual.excel');
});