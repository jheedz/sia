<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\Shift;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Position extends Model
{
    protected $fillable = ['code', 'name'];

    public function employees(): HasMany
    {
        return $this->hasMany(Employee::class);
    }
    
    public function shift(): BelongsTo
    {
        return $this->belongsTo(Shift::class);
    }
}