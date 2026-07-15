<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RemoveOldPositionFieldFromEmployeesTable extends Migration
{
    public function up(): void
    {
        Schema::table('employees', function (Blueprint $table) {
            // Kita suruh MySQL buat ngapus kolom 'position' yang string/lama
            $table->dropColumn('position');
        });
    }

    public function down(): void
    {
        Schema::table('employees', function (Blueprint $table) {
            // Opsi restore kalau seandainya di-rollback (opsional)
            $table->string('position')->nullable();
        });
    }
}