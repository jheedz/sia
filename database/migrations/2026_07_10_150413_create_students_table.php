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
        Schema::create('students', function (Blueprint $table) {
            $table->id();
            $table->string('nisn')->unique();      // Nomor Induk Siswa Nasional
            $table->string('name');              // Nama Lengkap Siswa
            $table->string('gender');  // Jenis Kelamin (Laki-laki / Perempuan)
            $table->date('birth_date');          // Tanggal Lahir
            $table->string('phone')->nullable();  // No HP Orang Tua / Siswa
            $table->enum('status', ['aktif', 'lulus', 'pindah', 'keluar'])->default('aktif');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('students');
    }
};
