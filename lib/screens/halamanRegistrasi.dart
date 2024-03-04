import 'package:flutter/material.dart';
import 'package:rumah_sakit/screens/halamanLogin.dart';

class HalamanRegistrasi extends StatefulWidget {
  const HalamanRegistrasi({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HalamanRegistrasiState createState() => _HalamanRegistrasiState();
}

class _HalamanRegistrasiState extends State<HalamanRegistrasi> {
  final _formKey = GlobalKey<FormState>();
  final _namaDepanController = TextEditingController();
  final _namaBelakangController = TextEditingController();

  final _nomerTeleponController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  FocusNode myFocusNode4 = FocusNode();
  FocusNode myFocusNode5 = FocusNode();

  bool _obscureText = true;

  // Fungsi untuk mengubah nilai _obscureText
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _namaDepanController.dispose();
    _namaBelakangController.dispose();
    _nomerTeleponController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HalamanLogin()),
                );
              },
              child: const Text(
                'Masuk Akun',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _title(),
              _formNamaDepan(),
              _formNamaBelakang(),
              _formEmail(),
              _formNomerTelepon(),
              _formPassword(),
              _formRePassword(),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Jika form valid, tampilkan dialog
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return _pemberitahuanBerhasil();
                        },
                      );
                    }
                  },
                  child: Container(
                    width: 370,
                    height: 72,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 219, 231, 116),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Dialog _pemberitahuanBerhasil() {
    return Dialog(
      child: Container(
          width: 259,
          height: 370,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 142,
                height: 142,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 219, 231, 116),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_user,
                  size: 62,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 195,
                margin: const EdgeInsets.only(top: 40),
                child: const Text(
                  "Berhasil\nMembuat Akun",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 219, 231, 116),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HalamanLogin()),
                  );
                },
                child: Container(
                  width: 192,
                  height: 52,
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 135, 203, 198),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Container _formRePassword() {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 3),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _rePasswordController,
        obscureText: _obscureText,
        focusNode: myFocusNode5,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.black.withOpacity(0.10),

          hintText: 'Re-Password',
          hintStyle: const TextStyle(fontSize: 16),
          // Tambahkan IconButton di sini
          suffixIcon: IconButton(
            icon: Icon(
              // Ganti ikon berdasarkan apakah teks disembunyikan atau tidak
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap masukkan Password';
          } else if (value != _passwordController.text) {
            return 'Password dan Konfirmasi Password tidak sama';
          }
          // Tambahkan validasi password lainnya di sini jika diperlukan
          return null;
        },
      ),
    );
  }

  Container _formPassword() {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 3),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscureText,
        focusNode: myFocusNode4,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          // Ketika tombol enter ditekan, pindah ke TextFormField berikutnya
          FocusScope.of(context).requestFocus(myFocusNode5);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.black.withOpacity(0.10),

          hintText: 'Password',
          hintStyle: const TextStyle(fontSize: 16),
          // Tambahkan IconButton di sini
          suffixIcon: IconButton(
            icon: Icon(
              // Ganti ikon berdasarkan apakah teks disembunyikan atau tidak
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap masukkan Password';
          }
          // Tambahkan validasi password lainnya di sini jika diperlukan
          return null;
        },
      ),
    );
  }

  Container _formNomerTelepon() {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 3),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _nomerTeleponController,
        focusNode: myFocusNode3,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          // Ketika tombol enter ditekan, pindah ke TextFormField berikutnya
          FocusScope.of(context).requestFocus(myFocusNode4);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.black.withOpacity(0.10),
          hintText: 'Nomer Telepon',
          hintStyle: const TextStyle(fontSize: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap masukkan Nomer Telepon';
          }
          // Tambahkan validasi email lainnya di sini jika diperlukan
          return null;
        },
      ),
    );
  }

  Container _formEmail() {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 3),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _emailController,
        focusNode: myFocusNode2,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          // Ketika tombol enter ditekan, pindah ke TextFormField berikutnya
          FocusScope.of(context).requestFocus(myFocusNode3);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.black.withOpacity(0.10),
          hintText: 'Email',
          hintStyle: const TextStyle(fontSize: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap masukkan Email';
          } else if (!value.endsWith('.com')) {
            return 'Email harus berakhir dengan .com';
          }
          // Tambahkan validasi email lainnya di sini jika diperlukan
          return null;
        },
      ),
    );
  }

  Container _formNamaBelakang() {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 3),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _namaBelakangController,
        focusNode: myFocusNode1,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          // Ketika tombol enter ditekan, pindah ke TextFormField berikutnya
          FocusScope.of(context).requestFocus(myFocusNode2);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.black.withOpacity(0.10),
          hintText: 'Nama Belakang',
          hintStyle: const TextStyle(fontSize: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap masukkan Nama Belakang';
          }

          return null;
        },
      ),
    );
  }

  Container _formNamaDepan() {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _namaDepanController,
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
          hintText: 'Nama Depan',
          hintStyle: const TextStyle(fontSize: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap masukkan Nama Depan';
          }

          return null;
        },
      ),
    );
  }

  Container _title() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      child: const Text(
        "Daftar\nAkun",
        style:
            TextStyle(fontSize: 40, fontWeight: FontWeight.w700, height: 1.0),
      ),
    );
  }
}
