<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Employee extends Model
{
    use HasFactory;
    use SoftDeletes;
    // Menentukan nama tabel (opsional jika nama model & tabel sudah sinkron)
    protected $table = 'employees';

    // Izinkan kolom-kolom ini diisi oleh MoonShine
    protected $guarded = []; 

    protected $fillable = [
        'nip',
        'name',
        'email',
        'phone',
        'telegram_chat_id',
        'position_id',
        'status',
    ];
    // Jika kamu pakai kolom tanggal kustom, daftarkan di sini agar otomatis dikonversi jadi objek Carbon oleh Laravel
    protected $casts = [
        'joined_at' => 'date',
        'birthday' => 'date',
        'is_active' => 'boolean',
    ];

    public function attendances()
    {
        return $this->hasMany(Attendance::class);
    }
    
    public function position(): BelongsTo
    {
        return $this->belongsTo(Position::class);
    }
    public function getShiftAttribute()
    {
        return $this->position?->shift;
    }
    public function getNameWithNikAttribute(): string
    {
        // Pastikan nama kolom NIK di database agan disesuaikan (misal: 'nik' atau 'nip')
        $nik = $this->nik ?? 'Belum ada NIK'; 
        
        return "{$this->name} - {$nik}";
    }
    // Di dalam class Employee
    public function totalWorkingHours($startDate, $endDate): float
    {
        $filteredAttendances = $this->attendances->whereBetween('date', [$startDate, $endDate]);

        $totalHours = $filteredAttendances->sum('working_hours');

        return round($totalHours, 1);
    }
    public function getAgeAttribute(): ?int
    {
        if (! $this->birthday) {
            return null;
        }

        // Menghitung selisih tahun dari tanggal lahir sampai hari ini
        return $this->birthday->age; 
    }
}