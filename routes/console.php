<?php

use Illuminate\Support\Facades\Schedule;

// Schedule::command('report:fetch-engine-notif')
//     ->dailyAt('00:05')
//     ->withoutOverlapping()
//     ->appendOutputTo(storage_path('logs/engine-notif-fetch.log'));

Schedule::command('telegram:poll-attendance')->everyTwentySeconds();
Schedule::command('attendance:auto-generate')->dailyAt('17:05');
