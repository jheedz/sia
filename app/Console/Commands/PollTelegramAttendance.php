<?php
namespace App\Console\Commands;

use App\Models\Employee;
use App\Models\Attendance;
use App\Services\TelegramService;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Cache;

class PollTelegramAttendance extends Command
{
    protected $signature = 'telegram:poll-attendance';
    protected $description = 'Memantau dan memproses pesan masuk dari Telegram untuk absensi karyawan';

    public function handle()
    {
        // Resolve Telegram service from the container using string to avoid
        // static analysis errors if the class is not defined.
        $telegram = app('App\\Services\\TelegramService');
        // Ambil offset update terakhir dari cache agar pesan tidak diproses berulang
        $offset = Cache::get('telegram_last_update_id', 0);

        $updates = $telegram->getUpdates($offset);

        if (empty($updates)) {
            return Command::SUCCESS;
        }

        foreach ($updates as $update) {
            $updateId = $update['update_id'];
            
            // Simpan offset selanjutnya (+1 dari ID update terakhir)
            Cache::put('telegram_last_update_id', $updateId + 1);

            if (!isset($update['message'])) {
                continue;
            }

            $message = $update['message'];
            $chatId  = $message['chat']['id'];
            $text    = trim(strtolower($message['text'] ?? ''));

            // 1. Cari Karyawan Berdasarkan telegram_chat_id
            $employee = Employee::query()
                ->where('telegram_chat_id', '=', $chatId)
                ->first();

            if (!$employee) {
                $reply = "⚠️ <b>Akses Ditolak</b>\n" .
                         "ID Telegram Anda (<code>{$chatId}</code>) belum terdaftar di sistem.\n" .
                         "Silakan berikan ID ini ke HR/Admin untuk dihubungkan ke akun Anda.";
                $telegram->sendMessage($chatId, $reply);
                continue;
            }

            // 2. Olah Kata Kunci Chat
            $today = Carbon::today()->toDateString();
            $now   = Carbon::now();

            if (in_array($text, ['absen', 'masuk', 'absen masuk', '/masuk', '/start'])) {
                // Cek apakah sudah ada record absen hari ini
                $attendance = Attendance::firstOrCreate(
                    [
                        'employee_id' => $employee->id,
                        'date'        => $today,
                    ],
                    [
                        'clock_in' => $now->toTimeString(),
                        'status'   => $now->format('H:i') > '08:00' ? 'Terlambat' : 'Hadir',
                    ]
                );

                if ($attendance->wasRecentlyCreated) {
                    $reply = "✅ <b>Absen Masuk Berhasil!</b>\n\n" .
                             "Nama: <b>{$employee->name}</b>\n" .
                             "Jam Masuk: <b>{$now->format('H:i:s')} WIB</b>\n" .
                             "Status: <b>{$attendance->status}</b>\n\n" .
                             "Selamat bekerja! 💪";
                } else {
                    $reply = "ℹ️ Halo <b>{$employee->name}</b>, Anda sudah melakukan Absen Masuk hari ini pada pukul <b>{$attendance->clock_in} WIB</b>.";
                }

                $telegram->sendMessage($chatId, $reply);

            } elseif (in_array($text, ['pulang', 'absen pulang', '/pulang'])) {
                $attendance = Attendance::query()
                    ->where('employee_id', '=', $employee->id)
                    ->where('date', '=', $today)
                    ->first();

                if (!$attendance) {
                    $reply = "❌ <b>Gagal Absen Pulang</b>\nAnda belum melakukan Absen Masuk hari ini.";
                } elseif ($attendance->clock_out) {
                    $reply = "ℹ️ Anda sudah melakukan Absen Pulang hari ini pada pukul <b>{$attendance->clock_out} WIB</b>.";
                } else {
                    $attendance->update([
                        'clock_out' => $now->toTimeString(),
                    ]);

                    $reply = "👋 <b>Absen Pulang Berhasil!</b>\n\n" .
                             "Nama: <b>{$employee->name}</b>\n" .
                             "Jam Pulang: <b>{$now->format('H:i:s')} WIB</b>\n\n" .
                             "Terima kasih atas kerja kerasnya hari ini! Hati-hati di jalan.";
                }

                $telegram->sendMessage($chatId, $reply);

            } else {
                $reply = "🤖 <b>Bot Absensi Karyawan</b>\n\n" .
                         "Kata kunci yang tersedia:\n" .
                         "• ketik <b>absen</b> atau <b>masuk</b> untuk Absen Masuk\n" .
                         "• ketik <b>pulang</b> untuk Absen Pulang";
                $telegram->sendMessage($chatId, $reply);
            }
        }

        return Command::SUCCESS;
    }
}