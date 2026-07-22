<?php

declare(strict_types=1);

namespace App\MoonShine\Resources\MenuPermission;

use App\Models\MenuPermission;
use App\MoonShine\Resources\MenuPermission\Pages\MenuPermissionIndexPage;
use App\MoonShine\Resources\MenuPermission\Pages\MenuPermissionFormPage;
use App\MoonShine\Resources\MenuPermission\Pages\MenuPermissionDetailPage;

use MoonShine\Laravel\Resources\ModelResource;
use MoonShine\Support\Enums\PageType;
use MoonShine\UI\Fields\Select;
use MoonShine\Laravel\Fields\Relationships\BelongsTo;
use MoonShine\Contracts\Core\PageContract;
use App\MoonShine\Resources\MoonShineUserRole\MoonShineUserRoleResource;

/**
 * @extends ModelResource<MenuPermission, MenuPermissionIndexPage, MenuPermissionFormPage, MenuPermissionDetailPage>
 */
class MenuPermissionResource extends ModelResource
{
    protected string $model = MenuPermission::class;
    protected ?PageType $redirectAfterSave = PageType::INDEX;

    protected string $title = 'Menu Permissions';

    // 🟢 UBAH JADI PUBLIC DAN TAMBAHKAN OPTIONS NYA BIAR DI HALAMAN INDEX MUNCUL LABELNYA
    public function indexFields(): array
    {
        return [
            BelongsTo::make('Role', 'role', resource: MoonShineUserRoleResource::class),
            Select::make('Akses Menu', 'menu_key')
                ->options($this->getMenuOptions()),
        ];
    }

    public function formFields(): array
    {
        return [
            BelongsTo::make('Pilih Role', 'role', resource: MoonShineUserRoleResource::class)
                ->required(),

            Select::make('Pilih Akses Menu/Grup', 'menu_key')
                ->options($this->getMenuOptions()) // 🟢 Gunakan helper method di bawah agar sinkron
                ->required()
                ->searchable(),
        ];
    }

    // 🟢 HELPER BIAR TIDAK MENULIS OPTION DUA KALI (INDEX & FORM)
    protected function getMenuOptions(): array
    {
        return [
            // 1. Level Menu/Resource Individual (Manajemen)
            'resource_user'      => '🔑 Menu: MoonShine User',
            'resource_role'      => '🛡️ Menu: MoonShine User Role',
            'resource_permission'=> '⚙️ Menu: Hak Akses Menu',
            'resource_position'  => '💼 Menu: Positions',
            'resource_shift'     => '⏰ Page: Shifts',

            // 2. Level Menu/Resource Individual (Data Master & Absen)
            'resource_inventory' => '📦 Menu: Inventories',
            'resource_student'   => '🎓 Menu: Students',
            'resource_employee'  => '👥 Menu: Employees',
            'resource_attendance'=> '⏰ Menu: Attendances',

            // 3. Level Harian/Laporan Individual
            'page_report_all'    => '📊 Page: Laporan Absensi (Semua)',
            'page_report_single' => '👤 Page: Laporan Absensi (Individu)',
        ];
    }

    public function rules(mixed $item): array
    {
        return [
            'moonshine_user_role_id' => ['required'],
            'menu_key' => ['required'],
        ];
    }

    /**
     * @return list<class-string<PageContract>>
     */
    protected function pages(): array
    {
        return [
            MenuPermissionIndexPage::class,
            MenuPermissionFormPage::class,
            MenuPermissionDetailPage::class,
        ];
    }
}