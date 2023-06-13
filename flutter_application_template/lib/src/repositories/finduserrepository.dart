import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_template/src/utils/configs.dart' as API_URL;

class FindUserRepository {
  final String _baseUrl = API_URL.Configs.API_URL;

  Future<String?> findid_email(String name, String email) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/findid-email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // print(jsonData);
      // print(jsonData[0]);
      // print(jsonData[0]['id']);
      final String? id = jsonData.isEmpty ? null : jsonData[0]['id'];
      return id;
    } else {
      throw Exception('Failed to fetch JSON data');
    }
  }

  Future<String?> findid_phone(String name, String phone) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/findid-phone'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String, String>{'name': name, 'phone': phone}),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      // print(response.body);
      // print(jsonData[0]['id']);
      final String? id = jsonData.isEmpty ? null : jsonData[0]['id'];
      return id;
    } else {
      throw Exception('Failed to fetch JSON data');
    }
  }
}
