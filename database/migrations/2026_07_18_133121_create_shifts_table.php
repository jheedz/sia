<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */public function up(): void
{
    Schema::create('shifts', function (Blueprint $table) {
        $table->id();
        $table->string('name'); // Contoh: Regular, Shift Pagi, Shift Malam
        $table->time('clock_in'); // Jam Masuk (08:00:00)
        $table->time('clock_out'); // Jam Pulang (17:00:00)
        $table->timestamps();
        $table->softDeletes(); 
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('shifts');
    }
};
