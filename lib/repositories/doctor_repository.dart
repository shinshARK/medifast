import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rumah_sakit/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumah_sakit/models/user_models.dart';
import 'package:rumah_sakit/models/token.dart';
import 'package:rumah_sakit/models/dokter_model.dart';


class DoctorRepository {

  final SharedPreferences sharedPreferences;

  DoctorRepository(this.sharedPreferences);

  Future<List<DokterModel>> fetchDokter() async {

    final token = jsonDecode(sharedPreferences.getString('tokens') ?? '')['access_token'] ;
    print(token);
    final response = await http.get(
      Uri.parse('http://localhost:8000/doctor/'),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> doctorList = jsonResponse['doctor'];
    print(doctorList);
    return doctorList.map((data) => DokterModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load doctor');
    }

  }

  Future<DokterModel> fetchDokterById(int id) async {
    final token = jsonDecode(sharedPreferences.getString('tokens') ?? '')['access_token'] ;
    final response = await http.get(
      Uri.parse('http://localhost:8000/doctor/$id'),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode == 200) {
      // Map<String, dynamic> responseJson = json.decode(response.body);
      
      // print(responseJson);
      return DokterModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load doctor');
    }
  }
}