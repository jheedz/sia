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
}