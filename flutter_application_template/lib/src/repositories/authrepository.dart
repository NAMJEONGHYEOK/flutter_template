import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_template/src/utils/configs.dart' as API_URL;

class AuthRepository {
  final String _baseUrl = API_URL.Configs.API_URL;

  Future<http.Response> login(String id, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'password': password,
      }),
    );
    return response;
  }

  Future<http.Response> logout(String token) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }
}
