import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/models/userinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../repositories/authrepository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum Status { unauthentication, authenticatied } // 비인증, 인증 중, 인증 완료

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final bool _isLoggedIn = false; // _추가하여 외부접근 방지.
  bool _isAutoLogin = false;
  late String? _accessToken;
  // late User _currentUser;

  bool get isAutoLogin => _isAutoLogin;
  bool get isLoggedIn => _isLoggedIn;

  final AuthRepository _authRepository = AuthRepository();

  void autologin({bool autovalue = true}) {
    _isAutoLogin = autovalue;
    notifyListeners();
  }

  // access 토큰 getter,setter 저장
  Future<String?> get accessToken async {
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

  // refresh 토큰 getter 저장.
  Future<String?> getRefreshToken() async {
    String? refreshToken = await _storage.read(key: 'refreshToken');
    if (refreshToken != null && refreshToken.isNotEmpty) {
      return refreshToken;
    }
    return null;
  }

  // provider - login
  Future<http.Response> login(String id, String password) async {
    final response = await _authRepository.login(id, password);
    if (response.statusCode == 200) {
      final String? rawCookie = response.headers['set-cookie'];
      if (rawCookie != null) {
        // 추출한 쿠키 중에서 refreshToken 값을 찾아냅니다.
        final List<String> cookies = rawCookie.split(';');
        for (String cookie in cookies) {
          if (cookie.startsWith('refreshToken=')) {
            final String refreshToken =
                cookie.substring('refreshToken='.length);
            // 추출한 refreshToken 값을 안전하게 저장합니다.
            await _storage.write(key: 'refresh_token', value: refreshToken);
            break;
          }
        }
      }
      final Map<String, dynamic> data = json.decode(response.body);
      _setAccessToken(data['access_token']); // accessToken 저장.

      notifyListeners();
    }
    return response;
  }

  Future<http.Response> logout(String token) async {
    final response = await _authRepository.logout(token);
    if (response.statusCode == 204) {
      _accessToken = null;
      await _storage.delete(key: 'access_token');
      notifyListeners();
    }
    return response;
  }

  void Listener() {
    notifyListeners();
  }
}
