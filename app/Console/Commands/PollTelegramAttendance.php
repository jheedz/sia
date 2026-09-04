<?php

namespace App\Console\Commands;

use App\Models\Employee;
use App\Models\Attendance;
use App\Services\TelegramService;
use App\Services\TicketHandler;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Cache;

class PollTelegramAttendance extends Command
{
    protected $signature = 'telegram:poll-attendance';
    protected $description = 'Memantau dan memproses pesan masuk dari Telegram untuk absensi karyawan (Serta Lokasi GPS & Shift via Position)';

    // CONFIG KOORDINAT KANTOR & RADIUS MAKSIMAL (Dalam Meter)
    protected float $officeLat = -6.203770;  // Latitude Kantor
    protected float $officeLng = 106.803287; // Longitude Kantor
    protected int $maxRadius   = 100;        // Maksimal jarak 100 meter dari kantor

    public function handle(TelegramService $telegram, TicketHandler $ticketHandler)
    {
        $offset = Cache::get('telegram_last_update_id', 0);
        $updates = $telegram->getUpdates($offset);

        if (empty($updates)) {
            return Command::SUCCESS;
        }

        foreach ($updates as $update) {
            $updateId = $update['update_id'];
            Cache::put('telegram_last_update_id', $updateId + 1);

            if (!isset($update['message'])) {
                continue;
            }

            $message = $update['message'];
            $chatId  = $message['chat']['id'];
            $text    = trim(strtolower($message['text'] ?? ''));
            
            // Cek apakah user mengirimkan Lokasi GPS
            $location = $message['location'] ?? null;

            // 1. Cari Karyawan beserta Position dan Shift bertingkat (position.shift)
            $employee = Employee::with('position.shift')
                ->where('telegram_chat_id', '=', $chatId, 'and')
                ->first();

            if (!$employee) {
                $reply = "⚠️ <b>Akses Ditolak</b>\n" .
                         "ID Telegram Anda (<code>{$chatId}</code>) belum terdaftar di sistem.\n" .
                         "Silakan berikan ID ini ke HR/Admin.";
                $telegram->sendMessage($chatId, $reply);
                continue;
            }

            $today = Carbon::today()->toDateString();
            $now   = Carbon::now();

            // Skenario A: Karyawan Kirim Lokasi GPS
            if ($location) {
                $userLat = $location['latitude'];
                $userLng = $location['longitude'];

                // Hitung Jarak dari Kantor
                $distance = $this->calculateDistance($this->officeLat, $this->officeLng, $userLat, $userLng);

                // Validasi Radius Kantor
                if ($distance > $this->maxRadius) {
                    $reply = "❌ <b>Absen Gagal! Anda Di Luar Radius Kantor</b>\n\n" .
                             "Jarak Anda dari kantor: <b>{$distance} meter</b>\n" .
                             "Batas maksimal: <b>{$this->maxRadius} meter</b>\n\n" .
                             "Silakan kirim lokasi saat berada di area kantor.";
                    $telegram->sendMessage($chatId, $reply);
                    continue;
                }

                // --- 2. PENGECEKAN SHIFT LEWAT ACCESSOR ($employee->shift) ---
                $shift    = $employee->shift; // Mengakses position->shift
                $status   = 'Hadir';
                $lateNote = '';

                if ($shift && !empty($shift->clock_in)) {
                    // Carbon parsing jam masuk shift hari ini
                    $shiftStartTime = Carbon::parse($today . ' ' . $shift->clock_in);

                    if ($now->greaterThan($shiftStartTime)) {
                        $diffInMinutes = $now->diffInMinutes($shiftStartTime);
                        $status   = 'Terlambat ⚠️';
                        $lateNote = "\n(Jam Shift: {$shift->clock_in})";
                    }
                } else {
                    // Fallback jika posisi karyawan belum punya/set shift
                    if ($now->format('H:i') > '08:00') {
                        $status = 'Terlambat';
                    }
                }

                // Proses Absen Masuk dengan Lokasi & Shift ID
                $attendance = Attendance::firstOrCreate(
                    [
                        'employee_id' => $employee->id,
                        'date'        => $today,
                    ],
                    [
                        'clock_in'  => $now->toTimeString(),
                        'status'    => $status,
                        'latitude'  => $userLat,
                        'longitude' => $userLng,
                    ]
                );

                if ($attendance->wasRecentlyCreated) {
                    $shiftName = $shift ? $shift->name : 'Non-Shift';
                    $reply = "✅ <b>Absen Masuk Berhasil!</b>\n\n" .
                             "Nama: <b>{$employee->name}</b>\n" .
                             "Posisi: <b>" . ($employee->position?->name ?? '-') . "</b>\n" .
                             "Shift: <b>{$shiftName}</b>\n" .
                             "Jam Masuk: <b>{$now->format('H:i:s')} WIB</b>\n" .
                            //  "Jarak Kantor: <b>{$distance} meter</b>\n" .
                             "Status: <b>{$status}</b>" . $lateNote;
                } else {
                    $reply = "ℹ️ Anda sudah melakukan Absen Masuk hari ini pada pukul <b>{$attendance->clock_in} WIB</b>.";
                }

                $telegram->sendMessage($chatId, $reply);
                continue;
            }
            // Skenario B: Fitur TIKETING / LOGBOOK
            if (str_starts_with($text, '/tiket') || str_starts_with($text, 'tiket') || str_starts_with($text, '/lapor')) {
                $ticketHandler->handle($telegram, $employee, $text);
                continue;
            }

            // Skenario B: Pesan Teks Biasa
            if (in_array($text, ['absen', 'masuk', 'absen masuk', '/masuk', '/start'])) {
                $shift = $employee->shift;
                $shiftInfo = ($shift && $shift->clock_in)
                    ? "\nShift: <b>{$shift->name}</b> (" . substr($shift->clock_in, 0, 5) . " - " . substr($shift->clock_out, 0, 5) . " WIB)" 
                    : "";

                $reply = "📍 <b>Kirimkan Lokasi Anda</b>{$shiftInfo}\n\n" .
                         "Untuk melakukan Absen Masuk, silakan klik tombol <b>Attachment (📎)</b> -> pilih <b>Location (📍)</b> -> lalu pilih <b>Send My Current Location</b>.";
                $telegram->sendMessage($chatId, $reply);

            } elseif (in_array($text, ['pulang', 'absen pulang', '/pulang'])) {
                $attendance = Attendance::where('employee_id', '=', $employee->id, 'and')
                    ->where('date', '=', $today, 'and')
                    ->first();

                if (!$attendance) {
                    $reply = "❌ <b>Gagal Absen Pulang</b>\nAnda belum melakukan Absen Masuk hari ini.";
                } elseif ($attendance->clock_out) {
                    $reply = "ℹ️ Anda sudah Absen Pulang pada pukul <b>{$attendance->clock_out} WIB</b>.";
                } else {
                    $attendance->update([
                        'clock_out' => $now->toTimeString(),
                    ]);

                    $reply = "👋 <b>Absen Pulang Berhasil!</b>\n\n" .
                             "Nama: <b>{$employee->name}</b>\n" .
                             "Jam Pulang: <b>{$now->format('H:i:s')} WIB</b>\n\n" .
                             "Hati-hati di jalan!";
                }

                $telegram->sendMessage($chatId, $reply);

            } else {
                $reply = "🤖 <b>Bot Absensi Karyawan</b>\n\n" .
                         "• Ketik <b>absen</b> lalu ikuti petunjuk untuk kirim lokasi GPS.\n" .
                         "• Ketik <b>pulang</b> untuk Absen Pulang.";
                $telegram->sendMessage($chatId, $reply);
            }
        }

        return Command::SUCCESS;
    }

    private function calculateDistance($lat1, $lon1, $lat2, $lon2): float
    {
        $earthRadius = 6371000;

        $latFrom = deg2rad((float)$lat1);
        $lonFrom = deg2rad((float)$lon1);
        $latTo   = deg2rad((float)$lat2);
        $lonTo   = deg2rad((float)$lon2);

        $latDelta = $latTo - $latFrom;
        $lonDelta = $lonTo - $lonFrom;

        $angle = 2 * asin(sqrt(pow(sin($latDelta / 2), 2) +
            cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)));

        return round($angle * $earthRadius, 2);
    }
}