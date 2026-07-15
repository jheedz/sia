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
        Schema::create('employees', function (Blueprint $table) {
            $table->id();
            $table->string('nik')->unique();
            $table->string('name');
            $table->string('email')->unique();
            $table->date('joined_at');
            $table->boolean('is_active')->default(true);
            $table->foreignId('position_id')->constrained('positions')->onDelete('cascade');
            
            // Jika kamu mau pakai relasi departemen yang kita bahas tadi, tambahkan ini:
            // $table->foreignId('department_id')->constrained()->onDelete('cascade');
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('employees');
    }
};
