import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/utils/configs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import '../repositories/authrepository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum Status {
  unauthentication,
  authenticating,
  authenticatied
} // 비인증, 인증 중, 인증 완료

enum LoginPlatform {
  none,
  google,
  email,
  // 다른 로그인 플랫폼 추가 가능
}

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final bool _isLoggedIn = false; // _추가하여 외부접근 방지.
  bool _isAutoLogin = false;
  String? _accessToken = null;
  late LoginPlatform _loginPlatform = LoginPlatform.none;

  late GoogleSignIn _googleSignIn;
  late GoogleSignInAccount? _googleUser;
  GoogleSignInAccount? get googleUser => _googleUser;
  // late User _currentUser;

  bool get isAutoLogin => _isAutoLogin;
  bool get isLoggedIn => _isLoggedIn;
  String? get accessToken => _accessToken;
  LoginPlatform get loginPlatform => _loginPlatform;

  final AuthRepository _authRepository = AuthRepository();

  void autologin(bool autovalue) {
    _isAutoLogin = autovalue;
    _storage.write(
        key: 'isAutoLogin', value: "${_isAutoLogin}"); // int or string 만 저장가능
    // print(autovalue);
    notifyListeners();
  }

  AuthProvider() {
    _googleSignIn = GoogleSignIn(
      clientId: Configs.ClientID,
      scopes: [
        'email',
        'profile',
        'openid'

        // 다른 필요한 스코프도 여기에 추가할 수 있습니다.
      ],
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        print('name = ${googleUser.displayName}');
        print('email = ${googleUser.email}');
        print('id = ${googleUser.id}');
        // print('phone' = ${googleUser.});
        _loginPlatform = LoginPlatform.google;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
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

  // token - logout
  Future<void> logout(String token) async {
    switch (_loginPlatform) {
      case LoginPlatform.email:
        {
          final response = await _authRepository.logout(token);
          if (response.statusCode == 204) {
            _accessToken = null;
            await _storage.delete(key: 'access_token');
            await _storage.delete(key: 'refresh_token');
            notifyListeners();
          }
        }
      case LoginPlatform.google:
        try {
          await _googleSignIn.signOut();
          _googleUser = null;
          notifyListeners();
        } catch (error) {
          print(error);
        }
        break;
      // case LoginPlatform.kakao:
      //   break;
      // case LoginPlatform.naver:
      //   break;
      // case LoginPlatform.apple:
      // break;
      case LoginPlatform.none:
        break;
    }
  }

  void Listener() {
    notifyListeners();
  }
}
