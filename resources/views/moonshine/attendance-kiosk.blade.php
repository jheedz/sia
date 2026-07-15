<div class="space-y-6">

    <div class="text-center">
        <h1 class="text-4xl font-bold">
            🕒 ABSENSI KARYAWAN
        </h1>

        <p class="text-gray-500 mt-2">
            Silahkan masukkan NIK untuk melakukan absensi
        </p>
    </div>

    <div class="bg-white rounded-xl shadow p-8 max-w-xl mx-auto">

        <div class="mb-6">
            <label class="font-semibold">
                Jenis Absensi
            </label>

            <div class="flex gap-6 mt-3">
                <label>
                    <input
                        type="radio"
                        name="type"
                        value="clock_in"
                        checked
                    >
                    Clock In
                </label>

                <label>
                    <input
                        type="radio"
                        name="type"
                        value="clock_out"
                    >
                    Clock Out
                </label>
            </div>
        </div>

        <div class="mb-6">
            <label class="font-semibold">
                NIK
            </label>

            <input
                type="text"
                class="w-full border rounded-lg p-3 mt-2"
                placeholder="Masukkan NIK..."
                autofocus
            >
        </div>

        <button
            class="w-full bg-blue-600 hover:bg-blue-700 text-white rounded-lg py-3"
        >
            ABSEN SEKARANG
        </button>

    </div>

</div>