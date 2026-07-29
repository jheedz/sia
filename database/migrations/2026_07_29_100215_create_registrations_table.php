<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('registrations', function (Blueprint $table) {
            $table->id();
            $table->string('registration_number')->unique(); // Contoh: REG-202607-001
            $table->string('name');
            $table->enum('gender', ['L', 'P']);
            $table->date('birth_date');
            $table->string('address')->nullable();
            $table->string('phone')->nullable();
            $table->string('kia', 30)->nullable();
            $table->string('religion', 30)->nullable();
            $table->string('mother_name', 30)->nullable();
            $table->string('blood_type', 5)->nullable();
            $table->string('foto')->nullable();
            
            // Status Pendaftaran
            $table->enum('status', ['pending', 'verified', 'accepted', 'rejected'])
                  ->default('pending');
                  
            $table->text('notes')->nullable(); // Catatan admin (misal alasan ditolak)
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('registrations');
    }
};