import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rumah_sakit/components/bottomNavigasiBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumah_sakit/repositories/auth_repository.dart';
import '../models/user_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomortelponController = TextEditingController();
  bool isEditing = false;
  FocusNode myFocusNode1 = FocusNode();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final AuthRepository authRepository = AuthRepository(sharedPreferences);
    user = authRepository.getUser();

    // Set the initial values of the controllers
    _firstnameController.text = user?.firstname ?? '';
    _lastnameController.text = user?.lastname ?? '';
    _emailController.text = user?.email ?? '';
    _nomortelponController.text = user?.telephone ?? '';
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
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
            onPressed: isEditing
                ? _saveForm
                : () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
            child: Text(
              isEditing ? 'Simpan' : 'Edit',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500, color: Colors.black),
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
              _formFirstname(
                labelText: "Nama Depan",
              ),
              _formLastname(
                labelText: "Nama Belakang",
              ),
              _formemail(
                labelText: "Email",
              ),
              _formNomerTelepon(
                labelText: "Nomor Telpon",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      // Simpan data di sini
      _formKey.currentState!.save();

      // Misalnya, kita menyimpan data ke dalam variabel
      String firstname = _firstnameController.text;
      String lastname = _lastnameController.text;
      String email = _emailController.text;
      String nomorTelepon = _nomortelponController.text;

      // Ubah status isEditing menjadi false
      setState(() {
        isEditing = false;
      });

      // Update data pengguna
      UserModel updatedUser = UserModel(
        id: user?.id,
        firstname: firstname,
        lastname: lastname,
        email: email,
        telephone: nomorTelepon,
      );

      // Simpan data pengguna yang diperbarui ke SharedPreferences
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final AuthRepository authRepository = AuthRepository(sharedPreferences);
      await authRepository.saveUser(updatedUser);

      // Perbarui data pengguna di backend
      final response = await http.put(
        Uri.parse('http://localhost:8000/auth/update'),
        body: jsonEncode(updatedUser.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Jika permintaan berhasil, perbarui state user
        setState(() {
          user = updatedUser;
        });

        // Tampilkan pesan sukses atau lakukan aksi lainnya setelah data disimpan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data berhasil disimpan!')),
        );
      } else {
        // Jika permintaan gagal, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data!')),
        );
      }
    }
  }

  Container _formFirstname({
    required String labelText,
  }) {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _firstnameController,
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

  Container _formLastname({
    required String labelText,
  }) {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _lastnameController,
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

  Container _formemail({
    required String labelText,
  }) {
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
  }) {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _nomortelponController,
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
                      backgroundImage:
                          AssetImage('assets/images/profile_picture_2.png'),
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
