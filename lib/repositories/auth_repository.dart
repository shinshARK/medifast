import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_sakit/blocs/auth/auth_bloc.dart';
import 'package:rumah_sakit/models/user_models.dart';

class AuthRepository {
  // final AuthBloc _bloc;

  // AuthRepository(this._bloc);



  Future<bool> register(String namaDepan, String namaBelakang, String email, String telpon, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {'firstname': namaDepan,
        'lastname': namaBelakang,
        'email': email,
        'telephone': telpon,
        'password': password
        }
        ),
    );

    return response.statusCode == 201;
  }
}