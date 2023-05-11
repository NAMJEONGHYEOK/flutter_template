import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_template/src/utils/configs.dart' as API_URL;

class AuthRepository {
  final String _baseUrl = API_URL.Configs.API_URL;
  //  id, password 버튼 누를 경우
  Future<http.Response> login(String id, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'password': password,
      }),
    );

    return response;
  }

  // 자동 로그인 체크되어 fss 에서 토큰이 있는경우
  Future<http.Response> token_login(
      String? accessToken, String? refreshToken) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/token_login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String?, String?>{
        'access_token': accessToken,
        'refresh_token': refreshToken,
      }),
    );
    return response;
  }

  Future<http.Response> logout(String token) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': token}),
    );
    return response;
  }
}
