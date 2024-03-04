import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rumah_sakit/screens/halamanRegistrasi.dart';
import 'package:rumah_sakit/screens/home_screen.dart';

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HalamanLoginState createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  

  FocusNode myFocusNode1 = FocusNode();

  bool _obscureText = true;

  // Fungsi untuk mengubah nilai _obscureText
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void navigateToNextPage(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return  const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100.0, // Ubah lebar sesuai kebutuhan Anda
            height: 100.0, // Ubah tinggi sesuai kebutuhan Anda
            child: CircularProgressIndicator(strokeWidth: 10.0,color: Color.fromARGB(255, 135, 203, 198),),
          ),
        ],
      );
    },
  );

  await Future.delayed(const Duration(seconds: 10)); // Ubah durasi sesuai kebutuhan Anda

  // ignore: use_build_context_synchronously
  Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          // ignore: non_constant_identifier_names
                          builder: (Context) => home_screen(),
                        ),
                        (route) => false); // Navigasi ke halaman selanjutnya
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
                  MaterialPageRoute(
                      builder: (context) => const HalamanRegistrasi()),
                );
              },
              child: const Text(
                'Buat akun',
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
        child: Column(
          children: [
            _title(),
            _formEmail(),
            _formPassword(),
            Center(
              child: GestureDetector(
                onTap: () {
                  
                  //if (_formKey.currentState!.validate()) {
                    // ignore: non_constant_identifier_names
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(
                    //       // ignore: non_constant_identifier_names
                    //       builder: (Context) => home_screen(),
                    //     ),
                    //     (route) => false);
                    navigateToNextPage(context);
                  //}
                },
                child: Container(
                  width: 370,
                  height: 72,
                  margin: const EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 135, 203, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Masuk",
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
    );
  }

  Container _formPassword() {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscureText,
        focusNode: myFocusNode1,
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

  Container _formEmail() {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(top: 20),
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
          hintText: 'Email',
          hintStyle: const TextStyle(fontSize: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap masukkan Email';
          } else if (!value.endsWith('.com')) {
            return 'Email harus berakhir dengan @gmail.com';
          }
          // Tambahkan validasi email lainnya di sini jika diperlukan
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
        "Masuk\nAkun",
        style:
            TextStyle(fontSize: 40, fontWeight: FontWeight.w700, height: 1.0),
      ),
    );
  }
}
