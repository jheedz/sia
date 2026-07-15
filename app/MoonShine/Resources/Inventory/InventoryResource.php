<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\Inventory;

use Illuminate\Database\Eloquent\Model;
use App\Models\Inventory;
use App\MoonShine\Resources\Inventory\Pages\InventoryIndexPage;
use App\MoonShine\Resources\Inventory\Pages\InventoryFormPage;
use App\MoonShine\Resources\Inventory\Pages\InventoryDetailPage;

use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\Contracts\Core\PageContract;
use MoonShine\Support\Enums\PageType;
use MoonShine\UI\Fields\Text;
use MoonShine\UI\Fields\Number;
use MoonShine\Support\Enums\Action;   
use MoonShine\Support\ListOf;         
/**
 * @extends ModelResource<Inventory, InventoryIndexPage, InventoryFormPage, InventoryDetailPage>
 */
class InventoryResource extends ModelResource
{
    protected string $model = Inventory::class;

    protected string $title = 'Inventories';
    
    /**
     * @return list<class-string<PageContract>>
     */
    protected function pages(): array
    {
        return [
            InventoryIndexPage::class,
            InventoryFormPage::class,
            InventoryDetailPage::class,
        ];
    }
    protected ?PageType $redirectAfterSave = PageType::INDEX;

    public function search(): array
    {
        return ['item_code', 'item_name', 'location'];
    }

    /**
     * Trik Aman MoonShine v4:
     * Gunakan formFields() terpisah untuk Form Page agar tidak bentrok dengan method fields() default.
     */
    public function formFields(): array
    {
        return [
            Text::make('Kode Barang', 'item_code')
                ->required()
                ->placeholder('Contoh: BRG-001'),

            Text::make('Nama Barang', 'item_name')
                ->required(),

            // Input Stok (Memicu perhitungan total harga secara reaktif)
            Number::make('Jumlah Stok', 'stock')
                ->required()
                ->default(0),

            // Input Harga Satuan (Memicu perhitungan total harga secara reaktif)
            Number::make('Harga Satuan', 'price')
                ->required()
                ->default(0),

            Text::make('Lokasi Penyimpanan', 'location')
                ->placeholder('Contoh: Gudang Utama / Rak B3'),

            Text::make('Catatan', 'notes'),
        ];
    }

    /**
     * Tampilan untuk Halaman Index (Tabel Utama) & Detail
     */
    public function fields(): array
    {
        return [
            Text::make('Kode', 'item_code')->sortable(),
            Text::make('Nama Barang', 'item_name')->sortable(),
            Number::make('Stok', 'stock')->sortable(),
            Number::make('Harga Satuan', 'price', function($item) {
                return 'Rp ' . number_format((float) ($item->price ?? 0), 0, ',', '.');
            })->sortable(),
            Text::make('Lokasi', 'location'),
        ];
    }

    public function rules($item): array
    {
        return [
            'item_code' => ['required', 'string', 'unique:inventories,item_code,' . ($item->id ?? '')],
            'item_name' => ['required', 'string'],
            'stock' => ['required', 'integer', 'min:0'],
            'price' => ['required', 'numeric', 'min:0'],
        ];
    }
}
