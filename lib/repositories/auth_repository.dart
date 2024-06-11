import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rumah_sakit/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumah_sakit/models/user_models.dart';
import 'package:rumah_sakit/models/token.dart';

class AuthRepository {
  final SharedPreferences sharedPreferences;

  AuthRepository(this.sharedPreferences);

  Future<bool> register(String namaDepan, String namaBelakang, String email,
      String telpon, String password) async {
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
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body; // Assuming the response contains user data and Token
    } else {
      return null;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    final response = await http.put(
      Uri.parse('http://localhost:8000/auth/update'),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200;
  }

  Future<void> logout() async {
    await sharedPreferences.remove('access_token');
    await sharedPreferences.remove('refresh_token');
    await sharedPreferences.remove('user');
  }

  Future<void> saveTokens(Token token) async {
    await sharedPreferences.setString('tokens', jsonEncode(token.toJson()));
  }

  Token? getToken() {
    final tokenDataString = sharedPreferences.getString('tokens');
    if (tokenDataString != null) {
      final tokenData = jsonDecode(tokenDataString);
      return Token.fromJson(tokenData);
    }
    return null;
  }

  Future<void> saveUser(UserModel user) async {
    await sharedPreferences.setString('user', jsonEncode(user.toJson()));
  }

  UserModel? getUser() {
    final userDataString = sharedPreferences.getString('user');
    if (userDataString != null) {
      final userData = jsonDecode(userDataString);
      return UserModel.fromJson(userData);
    }
    return null;
  }
}
