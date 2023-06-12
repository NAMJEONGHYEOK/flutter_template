import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_template/src/utils/configs.dart' as API_URL;

class SignupRepository {
  final String _baseUrl = API_URL.Configs.API_URL;

  Future<http.Response> signup(String id, String password, String name,
      String email, String phone) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'password': password,
        'nmae': name,
        'email': email,
        'phone': phone
      }),
    );
    return response;
  }
}
