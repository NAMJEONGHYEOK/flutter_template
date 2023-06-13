import 'package:flutter/material.dart';

import '../models/userinfo.dart';

class UserInfoProvider extends ChangeNotifier {
  User? _userInfo;
  User? get userInfo => _userInfo;

  void setUserInfo(User userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }
}
