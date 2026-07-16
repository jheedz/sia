<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Attendance extends Model
{
    use SoftDeletes;
    protected $guarded = [];
    protected $casts = [
        'date' => 'date',
        'clock_in' => 'datetime',
        'clock_out' => 'datetime',
    ];
    public function employee(): BelongsTo
    {
        return $this->belongsTo(Employee::class);
    }
    // Di dalam class Attendance
    public function getWorkingHoursAttribute(): float
    {
        if ($this->clock_in && $this->clock_out) {
            // Hitung selisih menit lalu bagi 60 untuk mendapatkan jam
            $hours = $this->clock_in->diffInMinutes($this->clock_out) / 60;
            return round($hours, 1);
        }
        return 0.0;
    }
    
}