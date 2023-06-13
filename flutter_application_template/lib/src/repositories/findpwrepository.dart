import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_template/src/utils/configs.dart' as API_URL;

class FindPwRepository {
  final String _baseUrl = API_URL.Configs.API_URL;

  Future<String?> findpassword(String id, String name, String phone) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/findpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body:
          jsonEncode(<String, String>{'id': id, 'name': name, 'phone': phone}),
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final String? id = jsonData.isEmpty ? null : jsonData[0]['id'];
      return id;
    } else {
      throw Exception('Failed to fetch JSON data');
    }
  }
}
