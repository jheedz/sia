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
        Schema::table('students', function (Blueprint $table) {
            //
            $table->string('religion', 30)->nullable()->after('phone');
            $table->string('mother_name', 30)->nullable()->after('religion');
            $table->string('blood_type', 5)->nullable()->after('mother_name');
            $table->string('kia', 30)->nullable()->after('nisn');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('students', function (Blueprint $table) {
            //
            $table->dropColumn('religion');
            $table->dropColumn('mother_name');
            $table->dropColumn('blood_type');
            $table->dropColumn('kia');
        });
    }
};
