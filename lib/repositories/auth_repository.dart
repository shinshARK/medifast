import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rumah_sakit/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumah_sakit/models/user_models.dart';
import 'package:rumah_sakit/models/token.dart';

class AuthRepository {

  final SharedPreferences sharedPreferences;

  AuthRepository(this.sharedPreferences);

  Future<bool> register(String namaDepan, String namaBelakang, String email, String telpon, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/auth/register'),
      body: jsonEncode({
        'firstname': namaDepan,
        'lastname': namaBelakang,
        'email': email,
        'telephone': telpon,
        'password': password
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 201;
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/auth/login'),
      body: jsonEncode({
        'email': email,
        'password': password
      }),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body;  // Assuming the response contains user data and Token
    } else {
      return null;
    }
  }

  Future<void> logout() async {
    await sharedPreferences.remove('access_token');
    await sharedPreferences.remove('refresh_token');
    await sharedPreferences.remove('user');
  }

  Future<void> saveToken(String accessToken, String refreshToken) async {
    await sharedPreferences.setString('access_token', accessToken);
    await sharedPreferences.setString('refresh_token', refreshToken);
  }

  Token? getToken() {
    final accessToken = sharedPreferences.getString('access_token');
    final refreshToken = sharedPreferences.getString('refresh_token');
    if (accessToken != null && refreshToken != null) {
      return Token(accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  Future<void> saveUser(UserModel user) async {
    await sharedPreferences.setString('user', jsonEncode(user.toJson()));
  }

  UserModel? getUser()  {
    final userDataString = sharedPreferences.getString('user');
    if (userDataString != null) {
      final userData = jsonDecode(userDataString);
      return UserModel.fromJson(userData);
    }
    return null;
  }
}
