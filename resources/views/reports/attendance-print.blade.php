<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Laporan Absensi Karyawan - {{ $monthName }}</title>
    <style>
        body { font-family: Arial, sans-serif; font-size: 12px; color: #333; line-height: 1.4; }
        .header { text-align: center; margin-bottom: 20px; }
        .header h2 { margin: 0; text-transform: uppercase; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #000; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .text-center { text-align: center; }
        @media print {
            .no-print { display: none; }
            body { padding: 0; }
        }
    </style>
</head>
<body>

    <div class="no-print" style="background: #fff9e6; padding: 10px; margin-bottom: 20px; border: 1px solid #ffe0b2;">
        <button onclick="window.print()" style="padding: 8px 15px; background: #0d8abc; color: #fff; border: none; cursor: pointer; border-radius: 4px;">
            🖨️ Cetak / Simpan PDF
        </button>
    </div>

    <div class="header">
        <h2>Laporan Kehadiran Karyawan</h2>
        <div>Periode: <strong>{{ $monthName }}</strong></div>
    </div>

    <table>
        <thead>
            <tr>
                <th width="5%" class="text-center">No</th>
                <th>Nama Karyawan</th>
                <th>Jabatan</th>
                <th class="text-center">Hadir (Hari)</th>
                <th class="text-center">Jam Kerja</th>
            </tr>
        </thead>
        <tbody>
            @foreach($employees as $index => $emp)
                <tr>
                    <td class="text-center">{{ $index + 1 }}</td>
                    <td>{{ $emp->name }}</td>
                    <td>{{ $emp->position?->name ?? '-' }}</td>
                    <td class="text-center">
                        {{-- Menghitung total jumlah hadir di bulan tersebut --}}
                        {{ $emp->attendances->where('status', 'hadir')->count() }}
                    </td>
                    <td class="text-center">
                        <strong>{{ $emp->totalWorkingHours($startDate, $endDate) }}</strong> Jam
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>

    <script>
        // Otomatis memicu dialog print saat halaman selesai dimuat
        window.onload = function() {
            window.print();
        }
    </script>
</body>
</html>