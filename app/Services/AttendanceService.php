<?php

namespace App\Services;

use App\Models\Attendance;
use App\Models\Employee;
use Carbon\Carbon;

class AttendanceService
{
    public function process(string $nik): array
    {
        $employee = $this->findEmployee($nik);

        if (!$employee) {
            return [
                'success' => false,
                'message' => 'NIK tidak ditemukan.',
            ];
        }

        $attendance = Attendance::where('employee_id', $employee->id)
            ->whereDate('date', today())
            ->first();


        if (!$attendance) {
            return $this->clockIn($employee);
        }
        
        return $this->clockOut($attendance, $employee);
    }

    /**
     * Cari employee berdasarkan NIK
     */
    private function findEmployee(string $nik): ?Employee
    {
        return Employee::where('nik', trim($nik))->first();
    }

    /**
     * Clock In
     */
    private function clockIn(Employee $employee): array
    {
        if(now()->format('H:i') > '08:00' ){
            $sts = 'terlambat';
        }else{
            $sts = 'hadir';

        }
        $attendance = Attendance::create([
            'employee_id' => $employee->id,
            'date'        => today(),
            'clock_in'    => now()->format('H:i:s'),
            'status'      => $sts,
        ]);

        return [
            'success'    => true,
            'type'       => 'clock_in',
            'employee'   => $employee,
            'attendance' => $attendance,
            'message'    => $sts .' '.now()->format('H:i:s'),
        ];
    }

    /**
     * Clock Out
     */
    private function clockOut(Attendance $attendance, Employee $employee): array
    {
        $clockOutTime = '11:00';
        if (now()->format('H:i') < $clockOutTime) {
            return [
                'success' => false,
                'type'    => 'clock_out',
                'employee'=> $employee,
                'message' => "Clock Out hanya dapat dilakukan mulai pukul {$clockOutTime}.",
            ];
        }
        $attendance->update([
            'clock_out' => now()->format('H:i:s'),
        ]);

        return [
            'success'    => true,
            'type'       => 'clock_out',
            'employee'   => $employee,
            'attendance' => $attendance,
            'message'    => 'Berhasil Clock Out pada '. now()->format('H:i:s'),
        ];
    }
}