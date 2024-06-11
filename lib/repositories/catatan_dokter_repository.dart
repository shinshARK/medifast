import 'package:rumah_sakit/models/catatan_dokter_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatatanDokterRepository {
  final String baseUrl;

  CatatanDokterRepository({required this.baseUrl});

  Future<List<CatatanDokterModel>> fetchCatatanDokter() async {
    final response = await http.get(Uri.parse('$baseUrl/catatan_dokter'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CatatanDokterModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load catatan dokter');
    }
  }

  Future<void> createCatatanDokter(CatatanDokterModel catatanDokter) async {
    final response = await http.post(
      Uri.parse('$baseUrl/catatan_dokter'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'gejala': catatanDokter.gejala,
        'diagnosa': catatanDokter.diagnosa,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create catatan dokter');
    }
  }

  Future<void> updateCatatanDokter(CatatanDokterModel catatanDokter) async {
    final response = await http.put(
      Uri.parse('$baseUrl/catatan_dokter/${catatanDokter.idCatatanDoctor}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'gejala': catatanDokter.gejala,
        'diagnosa': catatanDokter.diagnosa,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update catatan dokter');
    }
  }

  Future<void> deleteCatatanDokter(int idCatatanDoctor) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/catatan_dokter/$idCatatanDoctor'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete catatan dokter');
    }
  }
}
