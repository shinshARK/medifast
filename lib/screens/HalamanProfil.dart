import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rumah_sakit/components/bottomNavigasiBar.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable, camel_case_types
class HalamanProfil extends StatefulWidget {
  const HalamanProfil({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HalamanProfilstate createState() => _HalamanProfilstate();
}

class _HalamanProfilstate extends State<HalamanProfil> {
  // Define variables to hold user profile information
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _tanggallahirController = TextEditingController();
  final _emailController = TextEditingController();
  final _nomortelponController = TextEditingController();
  bool isEditing = false;
  FocusNode myFocusNode1 = FocusNode();
  String jenisKelamin = "Laki - Laki";

  @override
  void dispose() {
    _namaController.dispose();
    _tanggallahirController.dispose();
    _emailController.dispose();
    _nomortelponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavigasiBar(inputan: 4),
      appBar: AppBar(
        title: Text(
          'Edit Profil',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        elevation: 10,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        actions: <Widget>[
          TextButton(
            onPressed: 
            // isEditing ? _saveForm :
            () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: Text(
              isEditing ? 'Simpan' : 'Edit',
              style: GoogleFonts.inter(fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _profil(context),
              _formNama(
                labelText: "Nama Lengkap",
                initialValue: "Ilham Akbar",
              ),
              _formttl(
                labelText: "Tanggal Lahir",
                controller: _tanggallahirController,
              ),
              _formemail(
                labelText: "Email",
                initialValue: "IlhamAkbar@gmail.com",
              ),
              _formNomerTelepon(
                labelText: "Nomor Telpon",
                initialValue: "089123712873",
              ),
              _buildDropdownButtonFormField(
                labelText: "jenis Kelamin",
                initialValue: "laki laki",
              ),
            ],
          ),
        ),
      ),
    );
  }

// void _saveForm() {
//  if (_formKey.currentState!.validate()) {
//     // Simpan data di sini
//     _formKey.currentState!.save();
//     // Misalnya, kita menyimpan data ke dalam variabel
//     String nama = _namaController.text;
//     String tanggalLahir = _tanggallahirController.text;
//     String email = _emailController.text;
//     String nomorTelepon = _nomortelponController.text;
//     String jenisKelamin = this.jenisKelamin; // Menggunakan variabel jenisKelamin yang sudah ada

//     // Ubah status isEditing menjadi false
//     setState(() {
//       isEditing = false;
//     });
//  }
// }

  Container _formNama({
    required String labelText,
    required String initialValue,
  }) {
    final TextEditingController _namaController = TextEditingController(text: initialValue);
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _namaController,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          // Ketika tombol enter ditekan, pindah ke TextFormField berikutnya
          FocusScope.of(context).requestFocus(myFocusNode1);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.black.withOpacity(0.10),
          labelText: labelText,
          hintStyle: const TextStyle(fontSize: 16),
        ),
        enabled: isEditing,
      ),
    );
  }

  Container _formttl({
      required String labelText,
      required TextEditingController controller,
    }) {
      //final TextEditingController _tanggallahirController = TextEditingController(text: initialValue);
      return Container(
        width: 370,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            // Ketika tombol enter ditekan, pindah ke TextFormField berikutnya
            FocusScope.of(context).requestFocus(myFocusNode1);
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.black.withOpacity(0.10),
            labelText: labelText,
            hintStyle: const TextStyle(fontSize: 16),
            suffixIcon: const Icon(Icons.date_range),
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(new FocusNode()); // to prevent opening default keyboard
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              String formattedDate = DateFormat('dd - MMMM - yyyy').format(pickedDate); // format the date to desired format
              controller.text = formattedDate;
            }
          },
          enabled: isEditing,
        ),
      );
    }

  Container _formemail({
    required String labelText,
    required String initialValue,
  }) {
    final TextEditingController _emailController = TextEditingController(text: initialValue);
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _emailController,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          // Ketika tombol enter ditekan, pindah ke TextFormField berikutnya
          FocusScope.of(context).requestFocus(myFocusNode1);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.black.withOpacity(0.10),
          labelText: labelText,
          hintStyle: const TextStyle(fontSize: 16),
        ),
        enabled: isEditing,
      ),
    );
  }

  Container _formNomerTelepon({
    required String labelText,
    required String initialValue,
  }) {
    final TextEditingController _formNomerTelepon = TextEditingController(text: initialValue);
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _formNomerTelepon,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          // Ketika tombol enter ditekan, pindah ke TextFormField berikutnya
          FocusScope.of(context).requestFocus(myFocusNode1);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.black.withOpacity(0.10),
          labelText: labelText,
          hintStyle: const TextStyle(fontSize: 16),
        ),
        enabled: isEditing,
      ),
    );
  }

  Widget _buildDropdownButtonFormField({
  required String labelText,
  required String initialValue,
  }) {
  return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.black.withOpacity(0.10),
          labelText: labelText,
          hintStyle: const TextStyle(fontSize: 16),
        ),
        hint: Text(
          initialValue,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        items: isEditing ? ['Laki-Laki', 'Perempuan'].map((gender) => DropdownMenuItem<String>(
          value: gender,
          child: Text(
            gender,
            style: const TextStyle(fontSize: 16),
          ),
        )).toList() : null, // Gunakan items jika isEditing adalah true
        onChanged: isEditing ? (value) => setState(() => jenisKelamin = value!) : null, // Gunakan onChanged jika isEditing adalah true
      ),
  );
  }

  Stack _profil(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: 144.0,
            height: 144.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 52,
                backgroundColor: Colors.white.withOpacity(0.0),
                child: const Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/profile_picture_2.png'),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}