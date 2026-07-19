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

        // 🟢 VALIDASI UTAMA: Pastikan posisi dan shift karyawan sudah di-set
        if (!$employee->position || !$employee->position->shift) {
            return [
                'success' => false,
                'message' => 'Posisi atau Shift belum diatur oleh admin untuk karyawan ini.',
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
     * Cari employee berdasarkan NIK (dengan Eager Loading ke Position dan Shift)
     */
    private function findEmployee(string $nik): ?Employee
    {
        // 🟢 Menggunakan with() agar data relasi langsung ditarik dalam 1 query hemat energi
        return Employee::with(['position.shift'])
            ->where('nik', trim($nik))
            ->first();
    }

    /**
     * Clock In
     */
    private function clockIn(Employee $employee): array
    {
        // 🟢 Ambil aturan jam masuk dinamis dari shift posisinya
        $shift = $employee->position->shift;
        $shiftClockIn = Carbon::parse($shift->clock_in)->format('H:i');

        // Bandingkan jam sekarang dengan jam masuk shift
        if (now()->format('H:i') > $shiftClockIn) {
            $sts = 'terlambat';
        } else {
            $sts = 'hadir';
        }

        $attendance = Attendance::create([
            'employee_id' => $employee->id,
            'date'        => today(),
            'clock_in'    => now()->format('H:i:s'),
            'status'      => $sts,
            // 💡 Opsional: agan bisa simpan snapshot nama/jam shift di table attendance jika kolomnya ada
        ]);

        return [
            'success'    => true,
            'type'       => 'clock_in',
            'employee'   => $employee,
            'attendance' => $attendance,
            'message'    => 'Berhasil Absen Masuk (' . ucfirst($sts) . ') pada ' . now()->format('H:i:s'),
        ];
    }

    /**
     * Clock Out
     */
    private function clockOut(Attendance $attendance, Employee $employee): array
    {
        // 🟢 Ambil aturan jam pulang dinamis dari shift posisinya
        $shift = $employee->position->shift;
        $shiftClockOut = Carbon::parse($shift->clock_out)->format('H:i');

        // Bandingkan apakah jam sekarang sudah boleh pulang sesuai shift kerja
        if (now()->format('H:i') < $shiftClockOut) {
            return [
                'success' => false,
                'type'    => 'clock_out',
                'employee'=> $employee,
                'message' => "Clock Out gagal. Berdasarkan shift Anda ({$shift->name}), baru bisa dilakukan mulai pukul {$shiftClockOut}.",
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
            'message'    => 'Berhasil Clock Out pada ' . now()->format('H:i:s'),
        ];
    }
}