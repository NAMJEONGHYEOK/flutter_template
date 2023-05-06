import 'package:flutter/material.dart';

enum Status { unauthentication, authenticatied } // 비인증, 인증 중, 인증 완료

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false; // _추가하여 외부접근 방지.
  bool _isAutoLogin = false;

  bool get isAutoLogin => _isAutoLogin;
  bool get isLoggedIn => _isLoggedIn;

  void autologin({bool autovalue = true}) {
    this._isAutoLogin = autovalue;
    notifyListeners();
  }

  void login() {
    // 로그인 처리
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    // 로그아웃 처리
    _isLoggedIn = false;
    notifyListeners();
  }
}

// class Loginbutton extends ChangeNotifier {
//   UserInfoRepository _userInfoRepository = UserInfoRepository();
//   List<UserInfo> _userinfos = [];
//   List<UserInfo> get userinfos => _userinfos;
//   Status _status = Status.unauthentication; // 기본상태 비인증
//   Status get status => _status;

//   Future<bool> login(String id, String password) async {
//     List<UserInfo>? listUserInfos =
//         await _userInfoRepository.login(id, password);
//     //
//     print("777");

//     //추가적인 가공절차, 예외처리
//     if (listUserInfos != null) {
//       _userinfos = listUserInfos;
//       _status = Status.authenticatied; // 인증 완료
//       return true;
//     } else {
//       return false;
//     }
//   }

  // void Listener() {
  //   notifyListeners();
  // }

  // void init() {
  //   _userinfos = [];
  //   _status = Status.unauthentication; // 인증실패
  //   notifyListeners();
  // }
