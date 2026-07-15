<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Inventory extends Model
{
    protected $fillable = [
        'item_code',
        'item_name',
        'stock',
        'price',
        'total_value',
        'location',
        'notes',
    ];
}