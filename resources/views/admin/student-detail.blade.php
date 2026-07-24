<div class="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
    
    <!-- 🔴 KOLOM KIRI: Profile & QR Code -->
    <div class="lg:col-span-3 bg-gray-50/60 p-5 rounded-xl border border-gray-100 flex flex-col items-center text-center">
        <!-- Foto Profil -->
        <img 
            src="{{ $item->foto ? asset('storage/' . $item->foto) : 'https://ui-avatars.com/api/?name=' . urlencode($item->name ?? 'Student') }}" 
            alt="{{ $item->name }}" 
            class="w-32 h-32 object-cover rounded-full border-4 border-blue-400 shadow-sm mb-3" 
        />
        <h2 class="text-lg font-bold text-gray-800 mb-1">{{ ucwords($item->name ?? '-') }}</h2>
        
        <div >
            <div class="p-2 bg-white rounded-lg inline-block">
                {!! QrCode::size(140)->margin(1)->generate($item->nisn ?? '-') !!}
            </div>
            {{-- <img src="https://api.qrserver.com/v1/create-qr-code/?size=180x180&data={{ urlencode($item->nisn ?? '') }}" alt="QR Code NISN" class="w-32 h-32 mb-2" /> --}}
        </div>
    </div>

    <div class="lg:col-span-9 bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
        <h3 class="font-bold text-gray-800 pb-3 mb-4 border-b border-gray-100">Informasi Siswa</h3>
        
        <div class="overflow-x-auto">
            <table class="striped-table w-full text-left border-collapse py-3 px-3 font-mono font-bold text-blue-600 ">
                <tbody>
                    <tr >
                        <td >Nomer KIA</td>
                        <td>:</td>
                        <td class="py-3 px-3 font-mono font-bold text-blue-600 ">{{ $item->kia ?? '-' }}</td>
                    </tr>
                    <tr >
                        <td >Nomer Induk Siswa</td>
                        <td>:</td>
                        <td class="py-3 px-3 font-mono font-bold text-blue-600 ">{{ $item->nisn ?? '-' }}</td>
                    </tr>
                    <tr>
                        <td  >Status</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">{{ $item->status ?? '-' }}</td>
                    </tr>
                    <tr >
                        <td  >Jenis Kelamin</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">{{ $item->gender ?? '-' }}</td> 
                    </tr>
                    <tr>
                        <td  >Agama</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">{{ $item->religion ?? '-' }}</td>
                    </tr>
                    <tr >
                        <td  >Tanggal Lahir</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">
                            {{ $item->birth_date ? \Carbon\Carbon::parse($item->birth_date)->translatedFormat('d F Y') : '-' }}
                            ( {{ $item->age ?? '-' }} tahun )
                        </td>
                    </tr>
                    <tr>
                        <td  >Golongan Darah</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">{{ $item->blood_type ?? '-' }}</td>
                    </tr>
                    <tr>
                        <td  >Nama Ibu</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">{{ $item->mother_name ?? '-' }}</td>
                    </tr>
                    <tr >
                        <td  >No. Telepon</td>
                        <td >:</td>
                        <td class="py-3 px-3 font-medium text-gray-800">{{ $item->phone ?? '-' }}</td>
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