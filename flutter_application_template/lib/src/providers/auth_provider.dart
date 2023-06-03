import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../repositories/authrepository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum Status { unauthentication, authenticatied } // 비인증, 인증 중, 인증 완료

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final bool _isLoggedIn = false; // _추가하여 외부접근 방지.
  bool _isAutoLogin = false;
  String? _accessToken = null;

  // late User _currentUser;

  bool get isAutoLogin => _isAutoLogin;
  bool get isLoggedIn => _isLoggedIn;
  String? get accessToken => _accessToken;

  final AuthRepository _authRepository = AuthRepository();

  void autologin(bool autovalue) async {
    _isAutoLogin = autovalue;
    await _storage.write(
        key: 'isAutoLogin', value: "${_isAutoLogin}"); // int or string 만 저장가능
    print(autovalue);
    notifyListeners();
  }

  // access 토큰 getter,setter 저장
  Future<String?> getaccessToken() async {
    if (_accessToken != null) {
      return _accessToken;
    }
    _accessToken = (await _storage.read(key: 'access_token'))!;
    return _accessToken;
  }

  Future<void> _setAccessToken(String? token) async {
    _accessToken = token;
    await _storage.write(key: 'access_token', value: token ?? '');
    notifyListeners();
  }

  // refresh 토큰 getter ,setter.
  Future<String?> getRefreshToken() async {
    String? refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken != null && refreshToken.isNotEmpty) {
      return refreshToken;
    }
    return null;
  }

  Future<void> _setRefreshToken(String? token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  // provider - login
  Future<bool> login(String id, String password) async {
    final response = await _authRepository.login(id, password);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      _setAccessToken(data['accessToken']); // accessToken 저장.
      _setRefreshToken(data['refreshToken']); // refreshToken 저장.
      // print(getaccessToken());
      // print(getRefreshToken());

      notifyListeners();
      return true;
    }
    // else if (response.statusCode ==)
    return false;
  }

  // provider - token _login
  Future<bool> tokenLogin() async {
    await Future.delayed(Duration(seconds: 2)); // 2초 딜레이
    if (await _storage.read(key: 'isAutoLogin') != "false") {
      // "true" 일 경우에만  토큰 로그인 시도.
      String? access_token = await getaccessToken();
      String? refresh_token = await getRefreshToken();
      final response =
          await _authRepository.token_login(access_token, refresh_token);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _setAccessToken(data['accessToken']); // accessToken 저장.
        _setRefreshToken(data['refreshToken']); // refreshToken 저장.
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<bool> logout(String token) async {
    final response = await _authRepository.logout(token);
    if (response.statusCode == 204) {
      _accessToken = null;
      await _storage.delete(key: 'access_token');
      await _storage.delete(key: 'refresh_token');
      notifyListeners();
      return true;
    }
    return false;
  }

  void Listener() {
    notifyListeners();
  }
}
