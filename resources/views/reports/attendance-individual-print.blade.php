<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Laporan Absensi - {{ $employee->name }}</title>
    <style>
        /* 1. Tambahkan background watermark ke body menggunakan pseudo-element */
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

        /* 2. Tambahan khusus untuk browser agar memaksakan background tercetak saat di-print */
        @media print {
            body {
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
            }
            .no-print { display: none; }
        }
        body { font-family: Arial, sans-serif; font-size: 11px; color: #333; line-height: 1.2; }
        
        /* 1. KUNCI UTAMA: Bikin container header relatif agar koordinat logo mengacu ke sini */
        .header-container { 
            position: relative; 
            margin-bottom: 20px; 
            padding-top: 10px;
            min-height: 60px; /* Jaga jarak tinggi minimal agar tidak tabrakan */
        }
        
        .header { text-align: left; padding-right: 120px; } /* Beri ruang di kanan agar judul tidak menabrak logo */
        .header h2 { margin: 0 0 5px 0; font-size: 16px; }
        
        /* 2. LOGO KANAN ATAS */
        .logo-report {
            position: absolute;
            top: 0;
            right: 0;
            width: 100px; /* Sesuaikan lebar logo sekolah/perusahaan agan */
            height: auto;
        }

        .biodata { margin-bottom: 10px; }
        .biodata td { padding: 4px 4px; border: none; }
        table { width: 100%; border-collapse: collapse; margin-top: 5px; }
        th, td { border: 1px solid #000; padding: 4px; text-align: left; }
        th { background-color: #f2f2f2; }
        .text-center { text-align: center; }
        .badge { padding: 3px 6px; border-radius: 3px; font-weight: bold; }
        .badge-hadir { background: #e6f4ea; color: #137333; }
        .badge-absen { background: #fce8e6; color: #c5221f; }
        @media print { .no-print { display: none; } }
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
                <th width="10%">Hari</th>
                <th width="15%" class="text-center">Tanggal</th>
                <th width="15%" class="text-center">Jam Masuk</th>
                <th width="15%" class="text-center">Jam Keluar</th>
                <th width="15%" class="text-center">Durasi Kerja</th>
                <th width="15%" class="text-center">Status</th>
            </tr>
        </thead>
        <tbody>
            @foreach($calendarRange as $date)
                @php
                    $formattedDate = $date->format('Y-m-d');
                    $attendance = $attendances->get($formattedDate);
                    $isWeekend = $date->isWeekend(); 
                    $no = $loop->iteration;
                @endphp

                <tr class="{{ $isWeekend ? 'background: #0d8abc' : '' }}">
                    <td class="text-center">{{ $no }}</td>
                    <td>{{ $date->translatedFormat('l') }}</td>
                    <td class="text-center">{{ $date->format('d-m-Y') }}</td>

                    @if($attendance)
                        <td class="text-center text-muted">{{ $attendance->clock_in ? $attendance->clock_in->format('H:i') : '-' }}</td>
                        <td class="text-center text-muted">{{ $attendance->clock_out ? $attendance->clock_out->format('H:i') : '-' }}</td>
                        <td class="text-center text-muted">{{ $attendance->working_hours }} Jam</td>
                        <td>
                            @if($attendance->status === 'terlambat')
                                <span class="badge badge-warning">Terlambat</span>
                            @else
                                <span class="badge badge-success">{{ $attendance->status }}</span>
                            @endif
                        </td>
                    @elseif($isWeekend)
                        <td class="text-center text-muted"><em>-</em></td>
                        <td class="text-center text-muted">-</td>
                        <td class="text-center text-muted">-</td>
                        <td><span class="badge badge-secondary">Libur</span></td>
                    @else
                        <td class="text-center text-danger">-</td>
                        <td class="text-center text-danger">-</td>
                        <td class="text-center text-danger">-</td>
                        <td><span class="badge badge-danger">Alpha</span></td>
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