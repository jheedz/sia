<?php

namespace App\Services;

use App\Models\Employee;
use App\Models\Ticket;

class TicketHandler
{
    public function handle(TelegramService $telegram, Employee $employee, string $text): void
    {
        // 1. Ekstrak pesan tiket (Menghapus kata kunci /tiket atau tiket)
        $cleanMessage = trim(preg_replace('/^\/?(tiket|lapor|help)\s*/i', '', $text));

        if (empty($cleanMessage)) {
            $reply = "⚠️ <b>Format Tiket Salah</b>\n\n" .
                     "Gunakan format:\n" .
                     "<code>/tiket [Isi Permintaan/Laporan Anda]</code>\n\n" .
                     "<b>Contoh:</b>\n" .
                     "<code>/tiket Mohon update parameter shift saya menjadi Shift Pagi</code>";
            $telegram->sendMessage($employee->telegram_chat_id, $reply);
            return;
        }

        // 2. Simpan Tiket ke Database
        $ticketNumber = Ticket::generateTicketNumber();
        
        $ticket = Ticket::create([
            'employee_id'   => $employee->id,
            'ticket_number' => $ticketNumber,
            'category'      => $this->detectCategory($cleanMessage),
            'subject'       => $cleanMessage,
            'status'        => 'open',
            'priority'      => 'medium',
        ]);

        // 3. Balasan ke User
        $reply = "🎟️ <b>Tiket Berhasil Dibuat!</b>\n\n" .
                 "No. Tiket: <code>{$ticket->ticket_number}</code>\n" .
                 "Kategori: <b>{$ticket->category}</b>\n" .
                 "Pesan: <i>\"{$ticket->subject}\"</i>\n\n" .
                 "Status: ⏳ <b>OPEN</b> (Menunggu Admin)\n" .
                 "Tim Admin akan memproses permintaan Anda segera.";

        $telegram->sendMessage($employee->telegram_chat_id, $reply);
    }

    /**
     * Deteksi kategori tiket secara sederhana berdasarkan kata kunci
     */
    private function detectCategory(string $message): string
    {
        $lower = strtolower($message);

        if (str_contains($lower, 'shift') || str_contains($lower, 'jam kerja')) {
            return 'Shift';
        } elseif (str_contains($lower, 'absen') || str_contains($lower, 'lupa')) {
            return 'Absensi';
        } elseif (str_contains($lower, 'gaji') || str_contains($lower, 'payroll')) {
            return 'Finance';
        }

        return 'Umum';
    }
}