<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\Employee\Pages;

use MoonShine\Laravel\Pages\Crud\DetailPage;
use MoonShine\UI\Components\Layout\Box;

class EmployeeDetailPage extends DetailPage
{
    /**
     * 🟢 Mengubah Judul Page & Breadcrumb secara dinamis
     */
    public function getTitle(): string
    {
        $item = $this->getResource()->getItem();

        // Mengembalikan kata 'Detail [Nama Karyawan]'
        return $item && !empty($item->name) 
            ? 'Detail ' . ucwords($item->name) 
            : 'Detail Karyawan';
    }

    protected function mainLayer(): array
    {
        $item = $this->getResource()->getItem();

        return [
            Box::make([
                view('admin.employee-detail', ['item' => $item])
            ])
        ];
    }
}