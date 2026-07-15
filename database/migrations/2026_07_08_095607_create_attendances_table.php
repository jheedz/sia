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
        Schema::create('attendances', function (Blueprint $table) {
            $table->id();
            // Menghubungkan absensi dengan id karyawan
            $table->foreignId('employee_id')->constrained('employees')->onDelete('cascade');
            
            $table->date('date');            // Tanggal absen (cth: 2026-07-08)
            $table->time('clock_in');        // Jam masuk
            $table->time('clock_out')->nullable(); // Jam pulang (nullable karena diisi pas sore)
            $table->string('status');        // Hadir, Izin, Alpa, Terlambat
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendances');
    }
};
