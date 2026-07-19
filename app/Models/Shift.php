<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Shift extends Model
{
    // Izinkan kolom-kolom ini diisi massal
    protected $fillable = [
        'name',
        'clock_in',
        'clock_out',
    ];

    /**
     * Relasi ke model Position
     * Satu Shift bisa dipakai oleh banyak Posisi (contoh: Shift Regular dipakai Staff Admin & HRD)
     */
    public function positions(): HasMany
    {
        return $this->hasMany(Position::class);
    }
}