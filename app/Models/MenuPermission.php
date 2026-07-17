<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use MoonShine\Laravel\Models\MoonShineUserRole;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MenuPermission extends Model
{
    protected $fillable = ['moonshine_user_role_id', 'menu_key'];

    public function role(): BelongsTo
    {
        return $this->belongsTo(MoonShineUserRole::class, 'moonshine_user_role_id');
    }
}