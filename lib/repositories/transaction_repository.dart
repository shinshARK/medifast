import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rumah_sakit/models/riwayat_transaksi_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionRepository {
  final SharedPreferences sharedPreferences;

  TransactionRepository(this.sharedPreferences);

  Future<List<RiwayatTransaksiModel>> fetchTransactions(int userId) async {
    final token = jsonDecode(sharedPreferences.getString('tokens') ?? '')['access_token'];
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/transaction/?user_id=$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> riwayattransaksiList = jsonResponse['transactions'];
      // print(riwayattransaksiList);
      return riwayattransaksiList.map((data) => RiwayatTransaksiModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

Future<void> postTransaction(Map<String, dynamic> transactionData, Map<String, dynamic> pasien) async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final token = jsonDecode(sharedPreferences.getString('tokens') ?? '')['access_token'];

  // Ensure token is a String
  if (token is! String) {
    throw Exception('Access token is not a string');
  }

  try {
    final response2 = await http.post(
      Uri.parse('http://127.0.0.1:8000/pasien/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: pasien.map((key, value) => MapEntry(key, value.toString())), // Ensure all values are strings
    );

    final responseData = jsonDecode(response2.body);

    if (response2.statusCode == 200 || response2.statusCode == 409) {
      // Ensure id_pasien is a string in transactionData
      if (responseData["id_pasien"] is int) {
        transactionData["id_pasien"] = responseData["id_pasien"].toString();
      } else {
        transactionData["id_pasien"] = responseData["id_pasien"];
      }
    } else {
      throw Exception('Failed to handle pasien');
    }

    // Debugging line

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/transaction/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: transactionData.map((key, value) => MapEntry(key, value.toString())), // Ensure all values are strings
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to post transaction');
    }
  } catch (e) {
    throw Exception('An error occurred during the transaction process');
  }
}

Future<void> updateTransaction(int transactionId, Map<String, dynamic> updatedData) async {
    final token = jsonDecode(sharedPreferences.getString('tokens') ?? '')['access_token'];

    if (token is! String) {
      throw Exception('Access token is not a string');
    }

    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/transaction/$transactionId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: updatedData.map((key, value) => MapEntry(key, value.toString())),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update transaction');
    }
  }

}
