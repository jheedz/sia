<!DOCTYPE html>
<html>
<head>
    <title>Attendance Kiosk</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            margin: 0;
            background: #eef2f7;
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 80vh;
        }

        /* Container utama diubah jadi Flexbox */
        .container {
            width: 80%; /* Lebar ditambah agar muat 2 kolom */
            margin: 20px;
            background: white;
            border-radius: 20px;
            padding: 35px;
            box-shadow: 0 10px 40px rgba(33, 136, 79, 0.15);
            display: flex;
            gap: 40px; /* Jarak antar kolom kiri dan kanan */
        }

        /* Kolom Kiri: Jam & Form */
        .left-column {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        /* Kolom Kanan: Output Card & Message */
        .right-column {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: #f8fafc; /* Latar belakang soft agar area output kontras */
            padding: 20px;
            border-radius: 16px;
            border: 1px dashed #cbd5e1;
            min-height: 350px; /* Menjaga tinggi kolom kanan tetap konsisten */
        }

        .datetime {
            text-align: center;
            margin-bottom: 25px;
        }

        #current-date {
            font-size: 18px;
            color: #666;
            margin-bottom: 5px;
            text-transform: capitalize;
        }

        #current-time {
            font-size: 54px;
            font-weight: bold;
            color: #2563eb;
            letter-spacing: 2px;
        }

        form label {
            display: block;
            font-weight: 600;
            color: #475569;
            margin-bottom: 8px;
            font-size: 16px;
        }

        input {
            width: 100%;
            padding: 18px;
            font-size: 26px;
            border-radius: 12px;
            border: 2px solid #d1d5db;
            box-sizing: border-box;
            text-align: center;
            background: #fdfdfd;
        }

        input:focus {
            outline: none;
            border-color: #2563eb;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.15);
        }

        button {
            display: none;
        }

        /* Tampilan area kosong di kanan jika belum melakukan scan */
        .empty-state {
            text-align: center;
            color: #94a3b8;
            font-size: 18px;
        }

        .message {
            margin-top: 20px;
            padding: 15px;
            border-radius: 12px;
            font-size: 18px;
            text-align: center;
            font-weight: 600;
        }

        .success {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .employee-card {
            text-align: center;
            padding: 15px;
            border-radius: 10px;
            background: #ffffff;
            box-shadow: 0 4px 20px rgba(0,0,0,.04);
        }

        .employee-photo {
            width: 180px;
            height: 180px;
            object-fit: cover;
            border-radius: 10%;
            border: 3px solid #2563eb;
            margin-bottom: 5px;
        }

        .employee-name {
            font-size: 24px;
            font-weight: bold;
            color: #1e293b;
            margin: 5px 0;
        }

        .employee-nik {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .employee-position {
            display: inline-block;
            background: #e0f2fe;
            color: #0369a1;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- KOLOM KIRI: Jam & Input NIK -->
    <div class="left-column">
        <div class="datetime">
            <div id="current-date"></div>
            <div id="current-time">00:00:00</div>
        </div>
        
        <form method="POST" action="{{ route('attendance.process') }}">
            @csrf
            <label for="nik-input">Silahkan Scan Barcode / Ketik NIK Anda:</label>
            <input type="text" id="nik-input" name="nik" autofocus autocomplete="off" required>
            <button type="submit">ABSEN</button>
        </form>
    </div>

    <!-- KOLOM KANAN: Hasil Scan / Output -->
    <div class="right-column">
        @if(session('message'))
            <!-- Jika ada hasil scan dari session -->
            @if(session('employee'))
                <div class="employee-card">
                    <img class="employee-photo" 
                         src="{{ asset('storage/' . session('employee')->photo) }}" 
                         alt="{{ session('employee')->name }}">
                    <div class="employee-name">{{ session('employee')->name }}</div>
                    <div class="employee-nik">NIK: {{ session('employee')->nik }}</div>
                    <div class="employee-position">{{ session('employee')->position->name }}</div>
                </div>
            @endif
            
            <div class="message {{ session('success') ? 'success' : 'error' }}">
                {{ session('message') }}
            </div>
        @else
            <!-- State awal ketika aplikasi standby menunggu scan -->
            <div class="empty-state">
                <svg xmlns="http://www.w3.org/2000/svg" style="width:64px; height:64px; margin:0 auto 15px; display:block;" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z" />
                </svg>
                Menunggu Pemindaian 
            </div>
        @endif
    </div>
</div>

<script>
function updateClock(){
    const now = new Date();

    const dateOptions = {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    };

    document.getElementById('current-date').innerHTML = now.toLocaleDateString('id-ID', dateOptions);
    
    // Perbaikan: Memaksa format 24 jam agar menggunakan pemisah titik dua (:) secara seragam di semua browser
    document.getElementById('current-time').innerHTML = now.toLocaleTimeString('id-ID', { hour12: false }).replace(/\./g, ':');
}

// Jalankan fungsi langsung saat page load
updateClock();
setInterval(updateClock, 1000);

// Menjaga agar input NIK selalu autofocus secara otomatis jika user tidak sengaja klik di luar layar
document.addEventListener('click', function() {
    document.getElementById('nik-input').focus();
});
</script>

</body>
</html>