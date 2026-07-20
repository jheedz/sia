<?php

declare(strict_types=1);

namespace App\MoonShine\Layouts;

use App\MoonShine\Resources\MoonShineUser\MoonShineUserResource;
use App\MoonShine\Resources\MoonShineUserRole\MoonShineUserRoleResource;
use App\MoonShine\Resources\Employee\EmployeeResource;
use App\MoonShine\Resources\Attendance\AttendanceResource;
use App\MoonShine\Resources\Inventory\InventoryResource;
use App\MoonShine\Resources\Student\StudentResource;
use App\MoonShine\Resources\Position\PositionResource;
use App\MoonShine\Resources\MenuPermission\MenuPermissionResource;
use MoonShine\ColorManager\ColorManager;
use MoonShine\ColorManager\Palettes\PurplePalette;
use MoonShine\Contracts\ColorManager\ColorManagerContract;
use MoonShine\Contracts\ColorManager\PaletteContract;
use MoonShine\Laravel\Layouts\AppLayout;
use MoonShine\MenuManager\MenuGroup;
use MoonShine\MenuManager\MenuItem;
use App\MoonShine\Pages\AttendanceReportPage;
use App\MoonShine\Pages\AttendanceIndividualReportPage;
use App\MoonShine\Resources\Shift\ShiftResource;

final class MoonShineLayout extends AppLayout
{
    /**
     * @var null|class-string<PaletteContract>
     */
    protected ?string $palette = PurplePalette::class;

    protected function assets(): array
    {
        return [
            ...parent::assets(),
        ];
    }

    protected function menu(): array
    {
        $user = auth(moonshineConfig()->getGuard())->user();
        
        // 1. KOREKSI DI SINI: Jika tidak ada user login, return array kosong saja demi keamanan
        if (!$user) {
            return [];
        }

        // Jika Super User (Admin Utama), loloskan semua tanpa cek DB
        if ($user->isSuperUser()) {
            $hasAccess = fn($key) => true;
        } else {
            // Ambil daftar menu_key yang diizinkan untuk role user saat ini
            $allowedMenus = \DB::table('menu_permissions')
                ->where('moonshine_user_role_id', $user->moonshine_user_role_id)
                ->pluck('menu_key')
                ->toArray();

            $hasAccess = fn($key) => in_array($key, $allowedMenus);
        }

        return [
            // 1. GROUP MANAJEMEN (Otomatis tampil jika salah satu menu di dalamnya aktif)
            MenuGroup::make('Manajemen', [
                MenuItem::make(MoonShineUserResource::class, 'Users')
                    ->icon('users')
                    ->canSee(fn() => $hasAccess('resource_user')),

                MenuItem::make(MoonShineUserRoleResource::class, 'Roles')
                    ->icon('shield-check')
                    ->canSee(fn() => $hasAccess('resource_role')),

                MenuItem::make(MenuPermissionResource::class, 'Hak Akses Menu')
                    ->icon('key')
                    ->canSee(fn() => $hasAccess('resource_permission')),

                MenuItem::make(PositionResource::class, 'Positions')
                    ->icon('users')
                    ->canSee(fn() => $hasAccess('resource_position')),
            ])
            ->icon('cog-6-tooth')
            ->canSee(fn() => 
                $hasAccess('resource_user') || 
                $hasAccess('resource_role') || 
                $hasAccess('resource_permission') || 
                $hasAccess('resource_position')
            ), // 🟢 BISA DILIHAT JIKA SALAH SATU MENU DI DALAMNYA AKTIF

            // 2. GROUP DATA MASTER
            MenuGroup::make('Data Master', [
                MenuItem::make(InventoryResource::class, 'Inventories')
                    ->icon('briefcase')
                    ->canSee(fn() => $hasAccess('resource_inventory')),

                MenuItem::make(StudentResource::class, 'Students')
                    ->icon('academic-cap')
                    ->canSee(fn() => $hasAccess('resource_student')),

                MenuItem::make(EmployeeResource::class, 'Employees')
                    ->icon('users')
                    ->canSee(fn() => $hasAccess('resource_employee')),
            ])
            ->icon('bars-2')
            ->canSee(fn() => 
                $hasAccess('resource_inventory') || 
                $hasAccess('resource_student') || 
                $hasAccess('resource_employee')
            ), // 🟢 BISA DILIHAT JIKA SALAH SATU MENU DI DALAMNYA AKTIF

            // 3. GROUP REPORTING
            MenuGroup::make('Reporting', [
                MenuItem::make(AttendanceReportPage::class, 'Absensi')
                    ->icon('document-chart-bar')
                    ->canSee(fn() => $hasAccess('page_report_all')), 

                MenuItem::make(AttendanceIndividualReportPage::class, 'Absensi Karyawan')
                    ->icon('document-chart-bar')
                    ->canSee(fn() => $hasAccess('page_report_single')), 
            ])
            ->icon('presentation-chart-line')
            ->canSee(fn() => 
                $hasAccess('page_report_all') || 
                $hasAccess('page_report_single')
            ), // 🟢 BISA DILIHAT JIKA SALAH SATU MENU DI DALAMNYA AKTIF

            // 4. MENU MANDIRI (Attendances)
            MenuItem::make(AttendanceResource::class, 'Attendances')
                ->icon('clock')
                ->canSee(fn() => $hasAccess('resource_attendance')),
            MenuItem::make(ShiftResource::class, 'Shifts')
                ->icon('clock')
                ->canSee(fn() => $hasAccess('resource_shift')),
        ];
    }

    /**
     * @param ColorManager $colorManager
     */
    protected function colors(ColorManagerContract $colorManager): void
    {
        parent::colors($colorManager);
    }
}