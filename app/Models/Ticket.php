<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Ticket extends Model
{
    use HasFactory;

    protected $fillable = [
        'employee_id',
        'ticket_number',
        'category',
        'subject',
        'status',
        'priority',
        'admin_response',
        'handled_by',
    ];

    public function employee(): BelongsTo
    {
        return $this->belongsTo(Employee::class);
    }

    public function handler(): BelongsTo
    {
        return $this->belongsTo(User::class, 'handled_by');
    }

    /**
     * Generate Kode Tiket Otomatis
     */
    public static function generateTicketNumber(): string
    {
        $datePrefix = 'TKT-' . now()->format('Ymd') . '-';
        $lastTicket = self::where('ticket_number', 'like', $datePrefix . '%')
            ->orderBy('id', 'desc')
            ->first();

        $sequence = $lastTicket ? ((int) substr($lastTicket->ticket_number, -3)) + 1 : 1;

        return $datePrefix . str_pad($sequence, 3, '0', STR_PAD_LEFT);
    }
}