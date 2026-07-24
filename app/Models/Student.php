<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    protected $fillable = [
        'nisn',
        'name',
        'gender',
        'birth_date',
        'address',
        'foto',
        'phone',
        'status',
    ];
    protected $casts = [
        'birth_date' => 'date',
    ];
    
    public function getAgeAttribute(): ?int
    {
        if (! $this->birth_date) {
            return null;
        }

        // Menghitung selisih tahun dari tanggal lahir sampai hari ini
        return $this->birth_date->age; 
    }
}