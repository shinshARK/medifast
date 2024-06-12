import 'package:flutter/material.dart';

import 'package:rumah_sakit/screens/Pilihan_Pembayaran.dart';
import 'package:rumah_sakit/screens/daftar_dokter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rumah_sakit/models/dokter_model.dart';

class Reservasi extends StatefulWidget {
  final DokterModel dokter;

  const Reservasi({Key? key, required this.dokter}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ReservasiState createState() => _ReservasiState();
}

class _ReservasiState extends State<Reservasi> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  // List berisi tanggal yang tidak bisa dipilih
  List<DateTime> disabledDates = [
    DateTime(DateTime.now().year, DateTime.now().month, 27),
    // Tambahkan tanggal lainnya di sini
  ];
  int selectedChoice = 0;
  final List<String> choices = [
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00"
  ];
  List<int> disabledIndices = [2, 4, 5];
  final _formKey = GlobalKey<FormState>();
  int _gender = 0;
  final List<int> _genders = [0, 1];
  // Membuat controller dengan teks awal
  final namaPasienController = TextEditingController(text: 'Immanuel Carlos');
  final umurController = TextEditingController(text: '6');
  final keluhanController = TextEditingController(text: 'Demam Tinggi');
  final alamatController =
      TextEditingController(text: 'Jl. Cibeunying Kidul No.2 Kota Bandung');
  @override
  Widget build(BuildContext context) {
    DokterModel dokter = widget.dokter;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            dokter.nama,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
          ),
        ),
      ),
      bottomNavigationBar: _BottomNavigasiBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 140, 247, 247)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.white.withOpacity(0.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/images/${dokter.image}'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dokter.nama,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          dokter.spesialis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                "Pilih Tanggal",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  color: const Color(0xFFCCCCCC),
                  borderRadius: BorderRadius.circular(20)),
              child: TableCalendar(
                // Menentukan tanggal awal dan akhir kalender
                firstDay: DateTime.now(), // Tanggal awal adalah hari ini
                lastDay: DateTime(DateTime.now().year +
                    10), // Tanggal akhir adalah 10 tahun dari sekarang

                // Tanggal yang sedang difokuskan
                focusedDay: _focusedDay,

                // Gaya header kalender
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false, // Menyembunyikan tombol format
                  titleCentered:
                      true, // Menempatkan judul (nama bulan) di tengah
                ),

                // Fungsi yang menentukan apakah suatu hari dipilih atau tidak
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay,
                      day); // Jika hari ini sama dengan _selectedDay, maka hari ini dipilih
                },

                // Fungsi yang dipanggil ketika pengguna memilih suatu hari
                onDaySelected: (selectedDay, focusedDay) {
                  // Jika tanggal yang dipilih ada dalam list disabledDates, maka tidak melakukan apa-apa
                  if (disabledDates
                      .any((date) => isSameDay(date, selectedDay))) {
                    return;
                  }
                  // Jika tidak, maka perbarui _selectedDay dan _focusedDay
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },

                // Format kalender (bulan, dua minggu, atau minggu)
                calendarFormat: _calendarFormat,

                // Fungsi yang dipanggil ketika pengguna mengubah format kalender
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format; // Perbarui _calendarFormat
                  });
                },

                // Fungsi yang dipanggil ketika pengguna mengubah halaman kalender
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay; // Perbarui _focusedDay
                },

                // Format kalender yang tersedia dan labelnya
                availableCalendarFormats: const {
                  CalendarFormat.month:
                      'Bulan', // Hanya format bulan yang tersedia
                },

                // Builder untuk mengubah tampilan kalender
                calendarBuilders: CalendarBuilders(
                  // Builder untuk tanggal biasa
                  defaultBuilder: (context, date, events) {
                    // Jika tanggal ada dalam list disabledDates, maka tampilkan dengan latar belakang hitam dan tulisan putih
                    if (disabledDates
                        .any((disabledDate) => isSameDay(disabledDate, date))) {
                      return Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    // Jika tidak, maka tampilkan seperti biasa
                    return null;
                  },

                  // Builder untuk tanggal yang dipilih
                  selectedBuilder: (context, date, events) {
                    // Tampilkan dengan border hitam
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black, // Warna border
                          width: 2.0, // Lebar border
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  },

                  // Builder untuk hari ini
                  todayBuilder: (context, date, events) {
                    // Tampilkan dengan tulisan hitam
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                "Pilih Jam",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            // Loop untuk setiap baris dalam grid
            for (int i = 0; i < choices.length / 3; i++)
              // Membuat baris dengan jarak yang sama antara setiap tombol
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Loop untuk setiap tombol dalam baris
                  for (int j = 0; j < 3; j++)
                    // Memberikan jarak antar tombol
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ElevatedButton(
                          // Mengatur warna dan bentuk tombol
                          style: ElevatedButton.styleFrom(
                            // Mengubah warna tombol berdasarkan pilihan yang dipilih
                            backgroundColor: selectedChoice == i * 3 + j
                                ? Colors.blue
                                : Colors.grey[200],
                            // Membuat tombol berbentuk persegi panjang dengan border radius 20
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          // Mengatur aksi ketika tombol ditekan
                          onPressed: disabledIndices.contains(i * 3 + j)
                              ? null // Jika indeks tombol ada dalam daftar indeks yang tidak bisa diklik, maka tombol tidak bisa ditekan
                              : () {
                                  // Jika tombol bisa ditekan, maka ubah pilihan yang dipilih ketika tombol ditekan
                                  setState(() {
                                    selectedChoice = i * 3 + j;
                                  });
                                },
                          // Menampilkan teks pada tombol
                          child: Padding(
                            // Memberikan padding pada teks
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Text(
                              // Menampilkan pilihan pada tombol
                              choices[i * 3 + j],
                              // Mengatur warna dan ukuran teks
                              style: TextStyle(
                                // Mengubah warna teks berdasarkan pilihan yang dipilih atau tidak bisa diklik
                                color: disabledIndices.contains(i * 3 + j)
                                    ? Colors.grey
                                    : (selectedChoice == i * 3 + j
                                        ? Colors.white
                                        : Colors.black),
                                fontSize: 18,
                              ),
                            ),
                          ),
<<<<<<< Updated upstream
=======
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dokter.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  dokter.specialty,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text(
                        "Pilih Tanggal",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xFFCCCCCC),
                          borderRadius: BorderRadius.circular(20)),
                      child: TableCalendar(
                        // Menentukan tanggal awal dan akhir kalender
                        firstDay:
                            DateTime.now(), // Tanggal awal adalah hari ini
                        lastDay: DateTime(DateTime.now().year +
                            1), // Tanggal akhir adalah 10 tahun dari sekarang

                        // Tanggal yang sedang difokuskan
                        focusedDay: _focusedDay,

                        // Gaya header kalender
                        headerStyle: const HeaderStyle(
                          formatButtonVisible:
                              false, // Menyembunyikan tombol format
                          titleCentered:
                              true, // Menempatkan judul (nama bulan) di tengah
>>>>>>> Stashed changes
                        ),
                      ),
                    ),
                ],
              ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                "Data Pasien",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nama Pasien',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        TextField(
                          controller:
                              namaPasienController, // Menggunakan controller
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Menghapus garis bawah
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Umur',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        TextField(
                          controller: umurController, // Menggunakan controller
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Menghapus garis bawah
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jenis Kelamin',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          value: _gender,
                          items: _genders.map((gender) {
                            return DropdownMenuItem<int>(
                              value: gender,
                              child:
                                  Text(gender == 0 ? 'Laki-laki' : 'Perempuan'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Keluhan',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        TextField(
                          controller:
                              keluhanController, // Menggunakan controller
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Menghapus garis bawah
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alamat',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        TextField(
                          controller:
                              alamatController, // Menggunakan controller
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Menghapus garis bawah
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  BottomAppBar _BottomNavigasiBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Pilihan_Pembayaran()),
          );
        },
        child: Container(
          width: 350,
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 135, 203, 198),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4.9,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: const Text(
            'Lanjut ke Pembayaran',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
