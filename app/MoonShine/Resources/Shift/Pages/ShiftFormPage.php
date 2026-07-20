<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\Shift\Pages;

use MoonShine\Laravel\Pages\Crud\FormPage;
use MoonShine\Contracts\UI\ComponentContract;
use MoonShine\Contracts\UI\FormBuilderContract;
use MoonShine\UI\Components\FormBuilder;
use MoonShine\Contracts\UI\FieldContract;
use MoonShine\Contracts\Core\TypeCasts\DataWrapperContract;
use App\MoonShine\Resources\Shift\ShiftResource;
use MoonShine\Support\ListOf;
use MoonShine\UI\Components\Layout\Box; // Pastikan Box tetap di-import
use Throwable;

/**
 * @extends FormPage<ShiftResource>
 */
class ShiftFormPage extends FormPage
{
    /**
     * @return list<ComponentContract|FieldContract>
     */
    protected function fields(): array
    {
        // Tetap mengambil flat array dari Resource
        return $this->getResource()->fields();
    }

    protected function buttons(): ListOf
    {
        return parent::buttons();
    }

    protected function formButtons(): ListOf
    {
        return parent::formButtons();
    }

    protected function rules(DataWrapperContract $item): array
    {
        return [];
    }

    /**
     * @param  FormBuilder  $component
     * @return FormBuilder
     */
    protected function modifyFormComponent(FormBuilderContract $component): FormBuilderContract
    {
        // 🟢 KOREKSI 1: Biarkan form builder default yang menangani fields
        // Jangan dibungkus Box di sini agar data otomatis terisi (auto-fill) saat edit
        return $component;
    }

    /**
     * @return list<ComponentContract>
     * @throws Throwable
     */
    protected function mainLayer(): array
    {
        // 🟢 KOREKSI 2: Bungkus komponen form bawaan ke dalam Box di level layout utama
        return [
            Box::make([
                parent::getFormComponent()
            ])
        ];
    }

    protected function topLayer(): array
    {
        return [...parent::topLayer()];
    }

    protected function bottomLayer(): array
    {
        return [...parent::bottomLayer()];
    }
}