<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Holiday;

class HolidaySeeder extends Seeder
{
    public function run(): void
    {
        $holidays = [
            // --- TAHUN 2025 ---
            ['date' => '2025-01-01', 'description' => 'Tahun Baru 2025 Masehi'],
            ['date' => '2025-01-27', 'description' => 'Isra Mikraj Nabi Muhammad SAW'],
            ['date' => '2025-01-29', 'description' => 'Tahun Baru Imlek 2576 Kongzili'],
            ['date' => '2025-03-29', 'description' => 'Hari Suci Nyepi Tahun Baru Saka 1947'],
            ['date' => '2025-03-31', 'description' => 'Hari Raya Idul Fitri 1446 Hijriah'],
            ['date' => '2025-04-01', 'description' => 'Hari Raya Idul Fitri 1446 Hijriah'],
            ['date' => '2025-04-18', 'description' => 'Wafat Yesus Kristus'],
            ['date' => '2025-04-20', 'description' => 'Hari Paskah'],
            ['date' => '2025-05-01', 'description' => 'Hari Buruh Internasional'],
            ['date' => '2025-05-12', 'description' => 'Hari Raya Waisak 2569 BE'],
            ['date' => '2025-05-29', 'description' => 'Kenaikan Yesus Kristus'],
            ['date' => '2025-06-01', 'description' => 'Hari Lahir Pancasila'],
            ['date' => '2025-06-06', 'description' => 'Hari Raya Idul Adha 1446 Hijriah'],
            ['date' => '2025-06-27', 'description' => '1 Muharam Tahun Baru Islam 1447 Hijriah'],
            ['date' => '2025-08-17', 'description' => 'Proklamasi Kemerdekaan RI'],
            ['date' => '2025-09-05', 'description' => 'Maulid Nabi Muhammad SAW'],
            ['date' => '2025-12-25', 'description' => 'Hari Raya Natal'],

            // --- TAHUN 2026 ---
            ['date' => '2026-01-01', 'description' => 'Tahun Baru 2026 Masehi'],
            ['date' => '2026-01-16', 'description' => 'Isra Mikraj Nabi Muhammad SAW'],
            ['date' => '2026-02-17', 'description' => 'Tahun Baru Imlek 2577 Kongzili'],
            ['date' => '2026-03-19', 'description' => 'Hari Suci Nyepi Tahun Baru Saka 1948'],
            ['date' => '2026-03-20', 'description' => 'Hari Raya Idul Fitri 1447 Hijriah'],
            ['date' => '2026-03-21', 'description' => 'Hari Raya Idul Fitri 1447 Hijriah'],
            ['date' => '2026-04-03', 'description' => 'Wafat Yesus Kristus'],
            ['date' => '2026-04-05', 'description' => 'Hari Paskah'],
            ['date' => '2026-05-01', 'description' => 'Hari Buruh Internasional'],
            ['date' => '2026-05-14', 'description' => 'Kenaikan Yesus Kristus'],
            ['date' => '2026-05-27', 'description' => 'Hari Raya Idul Adha 1447 Hijriah'],
            ['date' => '2026-05-31', 'description' => 'Hari Raya Waisak 2570 BE'],
            ['date' => '2026-06-01', 'description' => 'Hari Lahir Pancasila'],
            ['date' => '2026-06-16', 'description' => 'Tahun Baru Islam 1448 Hijriah'],
            ['date' => '2026-08-17', 'description' => 'Proklamasi Kemerdekaan RI'],
            ['date' => '2026-08-25', 'description' => 'Maulid Nabi Muhammad SAW'],
            ['date' => '2026-12-25', 'description' => 'Hari Raya Natal'],
        ];

        foreach ($holidays as $holiday) {
            Holiday::updateOrCreate(
                ['date' => $holiday['date']],
                [
                    'description' => $holiday['description'],
                    'is_national' => true,
                ]
            );
        }
    }
}