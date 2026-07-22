<div class="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
    
    <!-- 🔴 KOLOM KIRI: Profile & QR Code -->
    <div class="lg:col-span-3 bg-gray-50/60 p-5 rounded-xl border border-gray-100 flex flex-col items-center text-center">
        <!-- Foto Profil -->
        <img 
            src="{{ $item->photo ? asset('storage/' . $item->photo) : 'https://ui-avatars.com/api/?name=' . urlencode($item->name ?? 'User') }}" 
            alt="{{ $item->name }}" 
            class="w-32 h-32 object-cover rounded-full border-4 border-blue-500 shadow-sm mb-3" 
        />
        <h2 class="text-lg font-bold text-gray-800 mb-1">{{ ucwords($item->name ?? '-') }}</h2>
        
        <div >
            <div class="p-2 bg-white rounded-lg inline-block">
                {!! QrCode::size(140)->margin(1)->generate($item->nik ?? '-') !!}
            </div>
            {{-- <img src="https://api.qrserver.com/v1/create-qr-code/?size=180x180&data={{ urlencode($item->nik ?? '') }}" alt="QR Code NIK" class="w-32 h-32 mb-2" /> --}}
        </div>
    </div>

    <div class="lg:col-span-9 bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
        <h3 class="font-bold text-gray-800 pb-3 mb-4 border-b border-gray-100">Informasi Karyawan</h3>
        
        <div class="overflow-x-auto">
            <table class="striped-table w-full text-left border-collapse py-3 px-3 font-mono font-bold text-blue-600 ">
                <tbody>
                    <tr >
                        <td >Nomer Induk Karyawan</td>
                        <td>:</td>
                        <td class="py-3 px-3 font-mono font-bold text-blue-600 ">{{ $item->nik ?? '-' }}</td>
                    </tr>
                    <tr >
                        <td  >Posisi / Jabatan</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">{{ $item->position?->name ?? '-' }}</td>
                    </tr>
                    <tr >
                        <td  >Jenis Kelamin</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">{{ $item->gender ?? '-' }}</td> 
                    </tr>
                    <tr >
                        <td  >Tanggal Lahir</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">
                            {{ $item->birthday ? \Carbon\Carbon::parse($item->birthday)->translatedFormat('d F Y') : '-' }}
                        </td>
                    </tr>
                    <tr >
                        <td  >Email</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">{{ $item->email ?? '-' }}</td>
                    </tr>
                    <tr >
                        <td  >Tanggal Bergabung</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">
                            {{ $item->joined_at ? \Carbon\Carbon::parse($item->joined_at)->translatedFormat('d F Y') : '-' }}
                        </td>   
                    </tr>
                    <tr >
                        <td  >Shift Kerja</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">
                            {{ $item->position?->shift?->name ?? '-' }}  (
                            {{ \Carbon\Carbon::parse($item->position->shift->clock_in)->format('H:i') }} - 
                            {{ \Carbon\Carbon::parse($item->position->shift->clock_out)->format('H:i') }} )

                        </td>
                    </tr>
                    <tr class="odd:bg-white even:bg-gray-50/80 border-b border-gray -100 hover:bg-blue-50/30">
                        <td  >Status Karyawan</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">
                            @if($item->is_active)
                                <span class="px-2 py-1 bg-green-100 text-green-800 rounded-full text-sm font-semibold">Aktif</span>
                            @else
                                <span class="px-2 py-1 bg-red-100 text-red-800 rounded-full text-sm font-semibold">Nonaktif</span>
                            @endif
                        </td>
                    </tr>
                    <tr >
                        <td  >Alamat</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">{{ $item->address ?? '-' }}</td>        
                    </tr>   
                </tbody>
            </table>
            <!-- Block QR Code -->
        </div>
    </div>

</div>