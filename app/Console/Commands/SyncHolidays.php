<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;
use App\Models\Holiday;

class SyncHolidays extends Command
{
    protected $signature = 'holidays:sync {year?}';
    protected $description = 'Sinkronisasi tanggal merah nasional dari API ke database lokal';

    public function handle()
    {
        $year = $this->argument('year') ?? date('Y');
        $this->info("Sedang menarik data libur nasional untuk tahun {$year}...");

        try {
            // 🟢 Menggunakan endpoint alternatif gratis & tanpa limit
            $response = Http::withoutVerifying()
                ->timeout(10)
                ->get("https://dayoffapi.vercel.app/api?year={$year}");

            // Jika API utama (dayoffapi) 402 / error, otomatis fallback ke API cadangan (api-harilibur)
            if ($response->status() !== 200) {
                $this->warn("API Utama mengembalikan status {$response->status()}, mencoba API cadangan...");
                $response = Http::withoutVerifying()
                    ->timeout(10)
                    ->get("https://api-harilibur.vercel.app/api?year={$year}");
            }

            if ($response->successful() && is_array($response->json())) {
                $holidays = $response->json();
                $count = 0;

                foreach ($holidays as $item) {
                    // Penanganan flexibel untuk format response API
                    $isHoliday = $item['is_national_holiday'] ?? $item['is_holiday'] ?? true;
                    $tanggal   = $item['holiday_date'] ?? $item['tanggal'] ?? null;
                    $keterangan = $item['holiday_name'] ?? $item['keterangan'] ?? 'Libur Nasional';

                    if ($isHoliday && $tanggal) {
                        Holiday::updateOrCreate(
                            ['date' => date('Y-m-d', strtotime($tanggal))],
                            [
                                'description' => $keterangan,
                                'is_national' => true,
                            ]
                        );
                        $count++;
                    }
                }

                $this->info("Berhasil! {$count} tanggal merah tahun {$year} tersimpan di database lokal.");
            } else {
                $this->error("Gagal menarik data dari API (Status: {$response->status()}).");
            }
        } catch (\Exception $e) {
            $this->error("Terjadi kesalahan: " . $e->getMessage());
        }
    }
}