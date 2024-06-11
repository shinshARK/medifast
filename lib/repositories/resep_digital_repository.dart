import 'package:rumah_sakit/models/resep_digital.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResepDigitalRepository {
  final String baseUrl;

  ResepDigitalRepository({required this.baseUrl});

  Future<List<ResepDigital>> fetchResepDigitals() async {
    final response = await http.get(Uri.parse('$baseUrl/resep_digital'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ResepDigital.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load resep digital');
    }
  }

  Future<void> createResepDigital(ResepDigital resepDigital) async {
    final response = await http.post(
      Uri.parse('$baseUrl/resep_digital'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id_doctor': resepDigital.idDoctor,
        'id_pasien': resepDigital.idPasien,
        'id_obat': resepDigital.idObat,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create resep digital');
    }
  }

  Future<void> updateResepDigital(ResepDigital resepDigital) async {
    final response = await http.put(
      Uri.parse('$baseUrl/resep_digital/${resepDigital.idResepDigital}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id_doctor': resepDigital.idDoctor,
        'id_pasien': resepDigital.idPasien,
        'id_obat': resepDigital.idObat,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update resep digital');
    }
  }

  Future<void> deleteResepDigital(int idResepDigital) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/resep_digital/$idResepDigital'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete resep digital');
    }
  }
}
