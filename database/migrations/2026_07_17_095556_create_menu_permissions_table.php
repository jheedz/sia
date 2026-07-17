<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('menu_permissions', function (Blueprint $table) {
            $table->id();
            // Relasi ke tabel bawaan MoonShine User Roles
            $table->foreignId('moonshine_user_role_id')
                ->constrained('moonshine_user_roles')
                ->cascadeOnDelete();
            $table->string('menu_key'); // Menyimpan identitas menu unik (contoh: 'reporting')
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('menu_permissions');
    }
};
