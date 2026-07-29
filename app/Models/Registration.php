<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Registration extends Model
{
    protected $fillable = [
        'registration_number',
        'name',
        'gender',
        'birth_date',
        'address',
        'phone',
        'kia',
        'religion',
        'mother_name',
        'blood_type',
        'foto',
        'status',
        'notes',
    ];

    protected $casts = [
        'birth_date' => 'date',
    ];

    // Auto-generate Nomor Pendaftaran (misal: REG-202607-0001)
    protected static function booted(): void
    {
        static::creating(function ($registration) {
            if (empty($registration->registration_number)) {
                $prefix = 'REG-' . now()->format('Ym') . '-';
                $latest = self::where('registration_number', 'like', $prefix . '%', 'and')
                    ->orderBy('id', 'desc')
                    ->first();

                $nextNumber = $latest 
                    ? ((int) substr($latest->registration_number, -4)) + 1 
                    : 1;

                $registration->registration_number = $prefix . str_pad((string)$nextNumber, 4, '0', STR_PAD_LEFT);
            }
        });
    }
}