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
        $isAdmin = static fn (): bool =>
            auth(moonshineConfig()->getGuard())->user()?->isSuperUser() ?? false;

        return [
            // Manajemen user — hanya admin
            MenuGroup::make('Manajemen', [
                MenuItem::make(MoonShineUserResource::class)->icon('users'),
                MenuItem::make(MoonShineUserRoleResource::class)->icon('shield-check'),
                MenuItem::make(PositionResource::class, 'Positions')->icon('users'),
            ])->icon('cog-6-tooth')->canSee($isAdmin),

            MenuGroup::make('Data Master', [
                MenuItem::make(InventoryResource::class, 'Inventories')->icon('briefcase'),
                MenuItem::make(StudentResource::class, 'Students')->icon('academic-cap'),
                MenuItem::make(EmployeeResource::class, 'Employees')->icon('users'),
            ])->icon('bars-2'),
            MenuGroup::make('Reporting', [
                MenuItem::make(AttendanceReportPage::class, 'Absensi' )->icon('document-chart-bar'), 
                MenuItem::make(AttendanceIndividualReportPage::class, ' Absensi Karyawan' )->icon('document-chart-bar'), 
            ])->icon('presentation-chart-line'),
            MenuItem::make(AttendanceResource::class, 'Attendances')->icon('clock'),
            MenuItem::make(ShiftResource::class, 'Shifts'),
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
