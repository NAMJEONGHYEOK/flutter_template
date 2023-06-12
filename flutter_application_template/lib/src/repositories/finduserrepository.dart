import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_template/src/utils/configs.dart' as API_URL;

class FindUserRepository {
  final String _baseUrl = API_URL.Configs.API_URL;

  Future<http.Response> findid_email(String name, String email) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/findid-email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String, String>{
        'nmae': name,
        'email': email,
      }),
    );
    return response;
  }

  Future<http.Response> findid_phone(String name, String phone) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/findid-phone'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String, String>{'nmae': name, 'phone': phone}),
    );
    return response;
  }

  Future<http.Response> findpassword(
      String id, String name, String phone) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/findpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body:
          jsonEncode(<String, String>{'id': id, 'nmae': name, 'phone': phone}),
    );
    return response;
  }
}
