<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Laporan Absensi - {{ $employee->name }}</title>
    
    <!-- Dynamic CSS variable buat watermark logo -->
    <style>
        :root {
            --logo-url: url("{{ Storage::url('logo/logo.jpg') }}");
        }
    </style>
    
    <!-- Panggil CSS External (Pastikan lokasi file di public/css/print-attendance.css) -->
    <link rel="stylesheet" href="{{ asset('css/print-attendance.css') }}">
</head>
<body>
    <div class="no-print" style="margin-bottom: 20px;">
        <button onclick="window.print()" class="btn-print">
            🖨️ Cetak / Simpan PDF
        </button>
    </div>

    <div class="header-container">
        <div class="header">
            <h2>Laporan Kehadiran Karyawan Per Periode</h2>
            <div>Bulan: <strong>{{ $monthName }}</strong></div>
        </div>
        <img class="logo-report" src="{{ Storage::url('logo/logo.jpg') }}" alt="Logo">
    </div>

    <table class="table-biodata">
        <tr>
            <td><strong>Nama - NIK</strong></td>
            <td>: {{ strtoupper($employee->name) }} - {{ $employee->nik ?? '-' }}</td>
        </tr>
        <tr>
            <td><strong>Jabatan</strong></td>
            <td>: {{ $employee->position?->name ?? '-' }}</td>
        </tr>
        <tr>
            <td><strong>Total Jam Kerja</strong></td>
            <td>: <strong>{{ $employee->totalWorkingHours($startDate, $endDate) }} Jam</strong></td>
        </tr>
    </table>

    <table class="table-report">
        <thead>
            <tr>
                <th class="col-no">No</th>
                <th class="col-day">Hari</th>
                <th class="col-date">Tanggal</th>
                <th class="col-time">Jam Masuk</th>
                <th class="col-time">Jam Keluar</th>
                <th class="col-duration">Durasi Kerja</th>
                <th class="col-status">Status / Keterangan</th>
            </tr>
        </thead>
        <tbody>
            @foreach($calendarRange as $date)
                @php
                    $formattedDate = $date->format('Y-m-d');
                    $attendance    = $attendances->get($formattedDate);
                    $isWeekend     = $date->isWeekend(); 
                    $isHoliday     = array_key_exists($formattedDate, $holidays ?? []);
                    $no            = $loop->iteration;

                    $rowClass = '';
                    if ($isHoliday) {
                        $rowClass = 'row-holiday';
                    } elseif ($isWeekend) {
                        $rowClass = 'row-weekend';
                    }
                @endphp

                <tr class="{{ $rowClass }}">
                    <td class="col-no">{{ $no }}</td>
                    <td class="col-day">{{ $date->translatedFormat('l') }}</td>
                    <td class="col-date">{{ $date->format('d-m-Y') }}</td>

                    @if($attendance)
                        <td class="col-time">{{ $attendance->clock_in ? (is_string($attendance->clock_in) ? date('H:i', strtotime($attendance->clock_in)) : $attendance->clock_in->format('H:i')) : '-' }}</td>
                        <td class="col-time">{{ $attendance->clock_out ? (is_string($attendance->clock_out) ? date('H:i', strtotime($attendance->clock_out)) : $attendance->clock_out->format('H:i')) : '-' }}</td>
                        <td class="col-duration">{{ $attendance->working_hours ?? '-' }} Jam</td>
                        <td class="col-status">
                            @if($attendance->status === 'terlambat')
                                <span class="badge badge-warning">Terlambat</span>
                            @else
                                <span class="badge badge-success">{{ ucfirst($attendance->status) }}</span>
                            @endif
                        </td>
                    @elseif($isHoliday)
                        <td class="col-time text-muted">-</td>
                        <td class="col-time text-muted">-</td>
                        <td class="col-duration text-muted">-</td>
                        <td class="col-status">
                            <span class="badge badge-holiday">
                                🎈 {{ $holidays[$formattedDate] }}
                            </span>
                        </td>
                    @elseif($isWeekend)
                        <td class="col-time text-muted">-</td>
                        <td class="col-time text-muted">-</td>
                        <td class="col-duration text-muted">-</td>
                        <td class="col-status"><span class="badge badge-secondary">Week End</span></td>
                    @else
                        <td class="col-time text-danger">-</td>
                        <td class="col-time text-danger">-</td>
                        <td class="col-duration text-danger">-</td>
                        <td class="col-status"><span class="badge badge-danger">Alpha</span></td>
                    @endif
                </tr>
            @endforeach
        </tbody>
    </table>

    <script>
        window.onload = function() { window.print(); }
    </script>
</body>
</html>