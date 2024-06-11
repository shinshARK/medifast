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
      return riwayattransaksiList.map((data) => RiwayatTransaksiModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

 Future<void> postTransaction(Map<String, dynamic> transactionData) async {
  final token = jsonDecode(sharedPreferences.getString('tokens') ?? '')['access_token'];
  print('Posting transaction data: $transactionData'); // Debugging line
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/transaction/'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: transactionData,
  );

  if (response.statusCode != 200) {
    print('Error: ${response.body}'); // Debugging line
    throw Exception('Failed to post transaction');
  }
}

}
