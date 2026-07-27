<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Laporan Absensi - {{ $employee->name }}</title>
    <style>
        /* 1. Watermark background */
        body::before {
            content: "";
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%); 
            width: 600px;                     
            height: 600px;                    
            background-image: url("{{ Storage::url('logo/logo.jpg') }}");
            background-repeat: no-repeat;
            background-position: center;
            background-size: contain;
            opacity: 0.05;                    
            z-index: -1;                      
        }

        /* 2. Media Print Settings */
        @media print {
            body {
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
            }
            .no-print { display: none; }
        }
        body { font-family: Arial, sans-serif; font-size: 11px; color: #333; line-height: 1.2; }
        
        .header-container { 
            position: relative; 
            margin-bottom: 10px; 
            padding-top: 5px;
            min-height: 60px;
        }
        
        .header { text-align: left; padding-right: 120px; }
        .header h2 { margin: 0 0 5px 0; font-size: 16px; }
        
        .logo-report {
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: auto;
        }

        .biodata { margin-bottom: 5px; }
        .biodata td { padding: 3px 3px; border: none; }
        table { width: 100%; border-collapse: collapse; margin-top: 5px; }
        th, td { border: 1px solid #000; padding: 3px; text-align: left; }
        th { background-color: #f2f2f2; }
        .text-center { text-align: center; }
        
        /* Badges Style */
        .badge { padding: 3px 6px; border-radius: 3px; font-weight: bold; font-size: 10px; display: inline-block; }
        .badge-success { background: #e6f4ea; color: #137333; }
        .badge-warning { background: #fef7e0; color: #b06000; }
        .badge-danger { background: #fce8e6; color: #c5221f; }
        .badge-secondary { background: #e8eaed; color: #3c4043; }
        .badge-holiday { background: #fce8e6; color: #b91c1c; border: 1px solid #f87171; }

        /* Row Highlights */
        .row-weekend { background-color: #f8fafc !important; }
        .row-holiday { background-color: #fef2f2 !important; }
    </style>
</head>
<body>
    <div class="no-print" style="margin-bottom: 20px;">
        <button onclick="window.print()" style="padding: 8px 15px; background: #0d8abc; color: #fff; border: none; cursor: pointer; border-radius: 4px;">
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

    <table class="biodata" style="width: auto;">
        <tr><td><strong>Nama - NIK</strong></td><td>: {{ strtoupper($employee->name) }} - {{ $employee->nik ?? '-' }}</td></tr>
        <tr><td><strong>Jabatan</strong></td><td>: {{ $employee->position?->name ?? '-' }}</td></tr>
        <tr>
            <td><strong>Total Jam Kerja</strong></td>
            <td>: <strong>{{ $employee->totalWorkingHours($startDate, $endDate) }} Jam</strong></td>
        </tr>
    </table>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th width="5%" class="text-center">No</th>
                <th width="12%">Hari</th>
                <th width="13%" class="text-center">Tanggal</th>
                <th width="15%" class="text-center">Jam Masuk</th>
                <th width="15%" class="text-center">Jam Keluar</th>
                <th width="15%" class="text-center">Durasi Kerja</th>
                <th width="25%" class="text-center">Status / Keterangan</th>
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

                    // Tentukan class baris untuk styling
                    $rowClass = '';
                    if ($isHoliday) {
                        $rowClass = 'row-holiday';
                    } elseif ($isWeekend) {
                        $rowClass = 'row-weekend';
                    }
                @endphp

                <tr class="{{ $rowClass }}">
                    <td class="text-center">{{ $no }}</td>
                    <td>{{ $date->translatedFormat('l') }}</td>
                    <td class="text-center">{{ $date->format('d-m-Y') }}</td>

                    @if($attendance)
                        <td class="text-center">{{ $attendance->clock_in ? (is_string($attendance->clock_in) ? date('H:i', strtotime($attendance->clock_in)) : $attendance->clock_in->format('H:i')) : '-' }}</td>
                        <td class="text-center">{{ $attendance->clock_out ? (is_string($attendance->clock_out) ? date('H:i', strtotime($attendance->clock_out)) : $attendance->clock_out->format('H:i')) : '-' }}</td>
                        <td class="text-center">{{ $attendance->working_hours ?? '-' }} Jam</td>
                        <td class="text-center">
                            @if($attendance->status === 'terlambat')
                                <span class="badge badge-warning">Terlambat</span>
                            @else
                                <span class="badge badge-success">{{ ucfirst($attendance->status) }}</span>
                            @endif
                        </td>
                    @elseif($isHoliday)
                        <td class="text-center text-muted">-</td>
                        <td class="text-center text-muted">-</td>
                        <td class="text-center text-muted">-</td>
                        <td class="text-center">
                            <span class="badge badge-holiday">
                                🎈 {{ $holidays[$formattedDate] }}
                            </span>
                        </td>
                    @elseif($isWeekend)
                        <td class="text-center text-muted">-</td>
                        <td class="text-center text-muted">-</td>
                        <td class="text-center text-muted">-</td>
                        <td class="text-center"><span class="badge badge-secondary">Week End</span></td>
                    @else
                        <td class="text-center text-danger">-</td>
                        <td class="text-center text-danger">-</td>
                        <td class="text-center text-danger">-</td>
                        <td class="text-center"><span class="badge badge-danger">Alpha</span></td>
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