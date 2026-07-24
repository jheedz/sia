<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('employees', function (Blueprint $table) {
            // Kontak & Darurat
            $table->string('phone', 20)->nullable()->after('email');
            $table->string('emergency_contact_name')->nullable()->after('address');
            $table->string('emergency_contact_phone', 20)->nullable()->after('emergency_contact_name');
            $table->string('blood_type', 5)->nullable()->after('gender');

            // Status Kepegawaian
            $table->enum('employment_status', ['permanent', 'contract', 'probation', 'internship'])
                  ->default('contract')
                  ->after('is_active');
            $table->date('contract_end_at')->nullable()->after('joined_at');

            // Payroll / Rekening
            $table->string('bank_name', 50)->nullable()->after('employment_status');
            $table->string('bank_account_number', 50)->nullable()->after('bank_name');
            $table->string('bank_account_name')->nullable()->after('bank_account_number');
            $table->string('npwp', 30)->nullable()->after('bank_account_name');
            $table->string('religion', 30)->nullable()->after('npwp');

            // Relasi ke User Login (opsional)
            $table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete()->after('id');
        });
    }

    public function down(): void
    {
        Schema::table('employees', function (Blueprint $table) {
            $table->dropForeign(['user_id']);
            $table->dropColumn([
                'phone',
                'emergency_contact_name',
                'emergency_contact_phone',
                'blood_type',
                'religion',
                'employment_status',
                'contract_end_at',
                'bank_name',
                'bank_account_number',
                'bank_account_name',
                'npwp',
                'user_id',
            ]);
        });
    }
};