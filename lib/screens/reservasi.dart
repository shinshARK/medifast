import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_bloc.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_event.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_state.dart';
import 'package:rumah_sakit/components/popupcustom.dart';
import 'package:rumah_sakit/models/antrian_model.dart';
import 'package:rumah_sakit/models/dokter_shift_model.dart';
import 'package:rumah_sakit/models/shift_model.dart';
import 'package:rumah_sakit/models/user_models.dart';
import 'package:rumah_sakit/repositories/auth_repository.dart';

import 'package:rumah_sakit/screens/riwayatTransaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rumah_sakit/models/dokter_model.dart';

class Reservasi extends StatefulWidget {
  final DokterModel dokter;

  const Reservasi({super.key, required this.dokter});
  @override
  // ignore: library_private_types_in_public_api
  _ReservasiState createState() => _ReservasiState();
}

class _ReservasiState extends State<Reservasi> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  UserModel? user;
  // List berisi tanggal yang tidak bisa dipilih
  List<DateTime> disabledDates = [];

  Map<DateTime, List<int>> disabledIndices = {};
  Map<String, List<String>> choices = {};

  void isidata(DokterModel data) {
    Map<DateTime, int> temp = {};
    if (widget.dokter != null && widget.dokter.doctor_shifts != null) {
      for (var i = 0; i < widget.dokter.doctor_shifts.length; i++) {
        DokterShiftModel doctorShift = widget.dokter.doctor_shifts[i];
        ShiftModel shift = doctorShift.shift_type;
        List<String> sem = choices[shift.hari] ?? [];
        if (!sem.contains(shift.tipe_shift)) {
          sem.add(shift.tipe_shift);
        }

        choices[shift.hari] = sem;

        List<AntrianModel> antrian = doctorShift.antrian;
        for (var j = 0; j < antrian.length; j++) {
          DateTime tanggal = DateTime.parse(antrian[j]
              .tanggal); // asumsikan tanggal adalah variabel DateTime dalam AntrianModel

          if (shift.hari == getDayOfWeekInIndonesian(tanggal)) {
            int maxAntrian = antrian[j]
                .max_antrian; // asumsikan max_antrian adalah variabel int dalam AntrianModel

            int currentCount = temp[tanggal] ??
                0; // Gunakan null check operator ('??') untuk default ke 0 jika tanggal tidak ada

            // Tambahkan nilai antrian
            currentCount += antrian[j].current_antrian;

            // Perbarui temp dengan nilai yang dihitung
            temp[tanggal] = currentCount;
            print(currentCount);
            print(maxAntrian);
            if (currentCount >= maxAntrian) {
              // Dapatkan list yang ada atau buat list baru jika tidak ada
              List<int> dataTanggal =
                  disabledIndices.putIfAbsent(tanggal, () => []);
              List<String> sem = choices[shift.hari] ?? [];
              // Periksa apakah shift.tipe_shift sudah ada dalam choices, lalu tambahkan jika belum
              int shiftIndex =
                  sem.indexWhere((choice) => choice == shift.tipe_shift);
              if (!dataTanggal.contains(shiftIndex)) {
                dataTanggal.add(shiftIndex);
                disabledIndices[tanggal] =
                    dataTanggal; // Memperbarui map dengan list yang baru
                // print(shiftIndex);
              }
            }
          }
        }
      }
    }
  }

  int cariantrian(String hari, String jam) {
    bool ketemu = false;
    int hasil = 0;
    // print(hari);
    // print(jam);
    for (var i = 0; i < widget.dokter.doctor_shifts.length; i++) {
      DokterShiftModel doctorShift = widget.dokter.doctor_shifts[i];
      ShiftModel shift = doctorShift.shift_type;
      if (ketemu == false && shift.tipe_shift == jam && hari == shift.hari) {
        List<AntrianModel> antrian = doctorShift.antrian;
        int index = 0;
        while (index < antrian.length) {
          DateTime dateFromString = DateTime.parse(antrian[index].tanggal);
          if (antrian[index].current_antrian == 0 &&
              _selectedDay.day == dateFromString.day &&
              _selectedDay.month == dateFromString.month) {
            hasil = antrian[index].id_antrian;
            ketemu = true;
            break;
          }

          // Lakukan sesuatu dengan model

          index++;
        }
      }
    }
    return hasil;
  }

  final _formKey = GlobalKey<FormState>();
  int _gender = 0;
  final List<int> _genders = [0, 1];
  // Membuat controller dengan teks awal
  late TextEditingController namaPasienController;
  late TextEditingController umurController;
  late TextEditingController alamatController;

  String getDayOfWeekInIndonesian(DateTime date) {
    const daysOfWeekInIndonesian = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];
    return daysOfWeekInIndonesian[date.weekday - 1];
  }

  bool cekhari(DateTime hari) {
    // print(hari);
    return choices.containsKey(getDayOfWeekInIndonesian(hari));
  }

  Future<void> _fetchUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final AuthRepository authRepository = AuthRepository(sharedPreferences);
    setState(() {
      user = authRepository.getUser();
    });
  }

  Map<DateTime, int> selectedChoice = {};
  @override
  void initState() {
    super.initState();
    _initialize();
    isidata(widget.dokter);
    Iterator<DateTime> iterator = disabledIndices.keys.iterator;

    while (iterator.moveNext()) {
      DateTime date = iterator.current;
      List<int> indices = disabledIndices[date] ?? [];
      // print(date);
      if (choices.length > indices.length) {
        int i = 0;
        while (i < choices.length) {
          if (!indices.contains(i)) {
            selectedChoice[date] = i;
            break;
          }
          i++;
        }
      } else {
        disabledDates.add(date);
        // print(date);
        // print(_selectedDay);
        DateTime selectedDayWithoutTime =
            DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
        if (date == selectedDayWithoutTime) {
          _selectedDay = _selectedDay.add(const Duration(days: 1));
        }
      }
    }
    while (!cekhari(_selectedDay)) {
      // print("test");
      _selectedDay = _selectedDay.add(const Duration(days: 1));
    }
  }

  Future<void> _initialize() async {
    await _fetchUser();
    namaPasienController =
        TextEditingController(text: '${user?.firstname} ${user?.lastname}');
    umurController = TextEditingController();
    alamatController = TextEditingController();
  }

  int cekpilihan() {
    DateTime selectedDayWithoutTime =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    return selectedChoice[selectedDayWithoutTime] ?? 0;
  }

  bool isDisabled(int index) {
    DateTime selectedDayWithoutTime =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    // print(_selectedDayWithoutTime);
    if (disabledIndices.containsKey(selectedDayWithoutTime)) {
      return disabledIndices[selectedDayWithoutTime]!.contains(index);
    }
    return false;
  }

  String printjadwal(int nomer) {
    DateTime selectedDayWithoutTime =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);

    List<String> temp =
        choices[getDayOfWeekInIndonesian(selectedDayWithoutTime)] ?? [];
    // print(temp[nomer]);
    return temp[nomer];
  }

// Logika untuk menentukan warna teks
  Color getTextColor(int index) {
    if (isDisabled(index)) {
      return Colors.grey;
    } else if (cekpilihan() == index) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  int cekpanjangjadwal() {
    DateTime selectedDayWithoutTime =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    int panjang =
        choices[getDayOfWeekInIndonesian(selectedDayWithoutTime)]?.length ?? 0;
    // print(getDayOfWeekInIndonesian(selectedDayWithoutTime));
    if (panjang == 0) {
      return 0;
    } else {
      return panjang % 3 == 0 ? 3 : panjang % 3;
    }
  }

  final Map<String, String> _transactionData = {
    'id_doctor': '1',
    'id_antrian': '',
    'jumlah_pembayaran': '0',
    'id_user': '1',
    'status': 'Segera',
    'id_pasien': '1',
    'tipe_pembayaran': 'default',
  };

  void _submitTransaction() {
    if (_formKey.currentState!.validate()) {
      final Map<String, String> PasienData = {
        'nama_pasien': '${namaPasienController.text}',
        'umur': '${umurController.text}',
        'jenis_kelamin': '${_gender == 0 ? 'Laki-laki' : 'Perempuan'}',
        'alamat': '${alamatController.text}',
      };
      print("test");
      context.read<TransactionBloc>().add(PostTransactionRequested(
            transactionData: _transactionData,
            pasien: PasienData,
          ));
    } else {
      print("salah");
    }
  }

  @override
  Widget build(BuildContext context) {
    DokterModel dokter = widget.dokter;
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              dokter.name ?? '',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
            ),
          ),
        ),
        bottomNavigationBar: _BottomNavigasiBar(context, dokter),
        body: BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is PostTransactionSuccess) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Dialog(
                      child: PopupCustom(
                    page1: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const riwayatTransaksi()),
                      );
                    },
                    page2: () {},
                    jumlah_tombol: 1,
                    notif: 'berhasil',
                    judul_notif: 'Berhasil\nMemuat janji',
                    penjelasan_tambahan: '',
                    nama_tombol_1: 'lihat riwayat',
                    nama_tombol_2: '',
                  ));
                },
              );
            } else if (state is PostTransactionFailure) {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                      child: PopupCustom(
                    page1: () {
                      Navigator.pop(context);
                    },
                    page2: () {},
                    jumlah_tombol: 1,
                    notif: 'Gagal',
                    judul_notif: 'Gagal\nMembuat janji',
                    penjelasan_tambahan: '',
                    nama_tombol_1: 'masukan ulang',
                    nama_tombol_2: '',
                  ));
                },
              );
            }
          },
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is PostTransactionLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 10.0,
                      color: Color.fromARGB(255, 135, 203, 198)),
                );
              }
              return SingleChildScrollView(
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
                                    AssetImage('assets/images/${dokter.photo}'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dokter.name ?? '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  dokter.specialty ?? '',
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
                          } else if (!cekhari(selectedDay)) {
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
                            _calendarFormat =
                                format; // Perbarui _calendarFormat
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
                            if (disabledDates.any((disabledDate) =>
                                isSameDay(disabledDate, date))) {
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
                            } else if (!cekhari(date)) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  date.day.toString(),
                                  style: const TextStyle(color: Colors.grey),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    // Loop untuk setiap baris dalam grid
                    for (int i = 0; i < choices.length / 3; i++)
                      // Membuat baris dengan jarak yang sama antara setiap tombol
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          // Loop untuk setiap tombol dalam baris

                          children: List.generate(
                            cekpanjangjadwal(),
                            (j) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: ElevatedButton(
                                  // Mengatur warna dan bentuk tombol
                                  style: ElevatedButton.styleFrom(
                                    // Mengubah warna tombol berdasarkan pilihan yang dipilih
                                    backgroundColor: cekpilihan() == i * 3 + j
                                        ? Colors.blue
                                        : Colors.grey[200],
                                    // Membuat tombol berbentuk persegi panjang dengan border radius 20
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  // Mengatur aksi ketika tombol ditekan
                                  onPressed: () {
                                    int buttonIndex =
                                        i * 3 + j; // Calculate the button index
                                    DateTime selectedDayWithoutTime = DateTime(
                                        _selectedDay.year,
                                        _selectedDay.month,
                                        _selectedDay.day);

                                    // Check if the button index is disabled for the current date
                                    if (disabledIndices[selectedDayWithoutTime]
                                            ?.contains(buttonIndex) ??
                                        true &&
                                            disabledIndices[
                                                    selectedDayWithoutTime] !=
                                                null) {
                                      // Button is disabled, do nothing
                                      // print(disabledIndices[_selectedDayWithoutTime]);
                                    } else {
                                      // Button is enabled, update selectedChoice

                                      setState(() {
                                        selectedChoice[selectedDayWithoutTime] =
                                            i * 3 + j;
                                      });
                                    }
                                  },
                                  // Menampilkan teks pada tombol
                                  child: Padding(
                                    // Memberikan padding pada teks
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Text(
                                      // Menampilkan pilihan pada tombol
                                      printjadwal(i * 3 + j),
                                      // Mengatur warna dan ukuran teks
                                      style: TextStyle(
                                        // Mengubah warna teks berdasarkan pilihan yang dipilih atau tidak bisa diklik
                                        color: getTextColor(i * 3 + j),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text(
                        "Data Pasien",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Nama Pasien',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  TextFormField(
                                    controller: namaPasienController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nama Pasien tidak boleh kosong';
                                      }
                                      return null;
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Umur',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  TextFormField(
                                    controller: umurController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Umur tidak boleh kosong';
                                      }
                                      return null;
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Jenis Kelamin',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  DropdownButtonFormField<int>(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    value: _gender,
                                    items: _genders.map((gender) {
                                      return DropdownMenuItem<int>(
                                        value: gender,
                                        child: Text(gender == 0
                                            ? 'Laki-laki'
                                            : 'Perempuan'),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value!;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Jenis Kelamin tidak boleh kosong';
                                      }
                                      return null;
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Alamat',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  TextFormField(
                                    controller: alamatController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Alamat tidak boleh kosong';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  BottomAppBar _BottomNavigasiBar(BuildContext context, DokterModel dokter) {
    return BottomAppBar(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Pilihan_Pembayaran()),
          // );

          _transactionData["id_doctor"] = '${dokter.id}';
          int sem = cariantrian(getDayOfWeekInIndonesian(_selectedDay),
              printjadwal(cekpilihan()));
          if (sem != 0) {
            _transactionData["id_antrian"] = '${sem}';
          }

          _transactionData["id_user"] = '${user?.id}';
          print(_transactionData);

          _submitTransaction();
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
            'Pesan',
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
