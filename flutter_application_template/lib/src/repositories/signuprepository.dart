import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_application_template/src/utils/configs.dart' as API_URL;

class SignupRepository {
  final String _baseUrl = API_URL.Configs.API_URL;

  Future<String> signup(String id, String password, String name, String email,
      String phone, String type) async {
    final response = await post(
      Uri.parse('$_baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'password': password,
        'name': name,
        'email': email,
        'phone': phone,
        'type': type
      }),
    );

    final responseData = json.decode(response.body);
    final result = responseData['result'];
    final message = responseData['message'];

    if (response.statusCode == 200) {
      return result;
    }
    return 'error : ${response.statusCode} - $message';
  }
}
