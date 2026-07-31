<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class TelegramService
{
    protected string $baseUrl;

    public function __construct()
    {
        $token = config('services.telegram.bot_token');
        $this->baseUrl = "https://api.telegram.org/bot{$token}";
    }

    /**
     * Mengambil daftar pesan terbaru dari Telegram (Polling)
     */
    public function getUpdates(int $offset = 0): array
    {
        try {
            $response = Http::get("{$this->baseUrl}/getUpdates", [
                'offset' => $offset,
                'timeout' => 10,
            ]);

            return $response->json('result') ?? [];
        } catch (\Exception $e) {
            Log::error("Telegram GetUpdates Error: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Membalas pesan ke user
     */
    public function sendMessage(string|int $chatId, string $text): bool
    {
        try {
            $response = Http::post("{$this->baseUrl}/sendMessage", [
                'chat_id' => $chatId,
                'text' => $text,
                'parse_mode' => 'HTML',
            ]);

            return $response->successful();
        } catch (\Exception $e) {
            Log::error("Telegram SendMessage Error: " . $e->getMessage());
            return false;
        }
    }
    private function calculateDistance($lat1, $lon1, $lat2, $lon2): float
    {
        $earthRadius = 6371000; // Radius bumi dalam meter

        $latFrom = deg2rad((float)$lat1);
        $lonFrom = deg2rad((float)$lon1);
        $latTo   = deg2rad((float)$lat2);
        $lonTo   = deg2rad((float)$lon1); // Catatan: gunakan $lon2

        $latTo   = deg2rad((float)$lat2);
        $lonTo   = deg2rad((float)$lon2);

        $latDelta = $latTo - $latFrom;
        $lonDelta = $lonTo - $lonFrom;

        $angle = 2 * asin(sqrt(pow(sin($latDelta / 2), 2) +
            cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)));

        return round($angle * $earthRadius, 2); // Hasil dalam meter
    }
}