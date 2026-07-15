<!DOCTYPE html>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<html>
<head>
    <title>Attendance Kiosk</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body{
            margin:0;
            background:#eef2f7;
            font-family:'Poppins',sans-serif;
        }

        .container{
            width:650px;
            margin:40px auto;
            background:white;
            border-radius:20px;
            padding:30px;
            box-shadow:0 10px 40px rgba(33, 136, 79, 0.15);
        }

        .title{
            text-align:center;
            font-size:32px;
            font-weight:700;
            color:#2563eb;
        }

        .subtitle{
            text-align:center;
            color:#666;
            margin-bottom:20px;
        }

        .clock{
            text-align:center;
            font-size:48px;
            font-weight:bold;
            margin:25px 0;
            color:#111827;
        }

        input{
            width:100%;
            padding:20px;
            font-size:28px;
            border-radius:12px;
            border:2px solid #d1d5db;
            box-sizing:border-box;
            text-align:center;
        }

        input:focus{
            outline:none;
            border-color:#2563eb;
        }

        button{
            display:none;
        }

        .message{
            margin-top:35px;
            padding:20px;
            border-radius:12px;
            font-size:22px;
            text-align:center;
        }

        .success{
            background:#dcfce7;
            color:#166534;
        }

        .error{
            background:#fee2e2;
            color:#991b1b;
        }
        .datetime{
            text-align:center;
            margin-bottom:5px;
        }

        #current-date{
            font-size:20px;
            color:#666;
            margin-bottom:8px;
        }

        #current-time{
            font-size:54px;
            font-weight:bold;
            color:#2563eb;
            letter-spacing:3px;
        }
        .employee-card{

            margin-top:30px;
            text-align:center;
            padding:25px;
            border-radius:20px;
            background:#ffffff;
            box-shadow:0 10px 30px rgba(0,0,0,.08);
        }

        .employee-photo{

            width:160px;
            height:160px;
            object-fit:cover;
            border-radius:50%;
            border:5px solid #2563eb;
            margin-bottom:15px;
        }

        .employee-name{
            font-size:28px;
            font-weight:bold;
            margin:10px 0;
        }

        .employee-position{
            color:#666;
            font-size:18px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="datetime">
        <div id="current-date"></div>
        <div id="current-time"></div>
    </div>
    <form method="POST" action="{{ route('attendance.process') }}">
        @csrf
        <label>NIK</label>
        <input type="text" name="nik" autofocus autocomplete="off" required>
        <button type="submit">
            ABSEN
        </button>
    </form>
    @if(session('message'))
        @if(session('employee'))
            <div class="employee-card">
                <img
                    class="employee-photo"
                    src="{{ asset('storage/' . session('employee')->photo) }}"
                    alt="{{ session('employee')->name }}">
                <div class="employee-name">
                    {{ session('employee')->name }}
                </div>
                <div>
                    NIK : {{ session('employee')->nik }}
                </div>
                <div class="employee-position">
                    {{ session('employee')->position->name }}
                </div>
            </div>
        @endif
        
        <div class="message {{ session('success') ? 'success' : 'error' }}">
            {{ session('message') }}
        </div>
    @endif

</div>

</body>

</html>

<script>

function updateClock(){

    const now = new Date();

    const dateOptions = {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    };

    document.getElementById('current-date').innerHTML =
        now.toLocaleDateString('id-ID', dateOptions);

    document.getElementById('current-time').innerHTML =
        now.toLocaleTimeString('id-ID');
}

updateClock();

setInterval(updateClock,1000);

</script>