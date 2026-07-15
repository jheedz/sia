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
        Schema::create('inventories', function (Blueprint $table) {
            $table->id();
            $table->string('item_code')->unique(); // Kode Barang (cth: BRG-001)
            $table->string('item_name');          // Nama Barang
            $table->integer('stock')->default(0);  // Jumlah Stok
            $table->decimal('price', 12, 2);       // Harga Satuan
            $table->decimal('total_value', 12, 2)->nullable(); // Total Nilai (Stok x Harga) -> Diisi otomatis
            $table->string('location')->nullable(); // Lokasi penyimpanan (cth: Gudang A)
            $table->text('notes')->nullable();     // Catatan Tambahan
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inventories');
    }
};
