import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/repositories/signuprepository.dart';
import '../models/userinfo.dart' show User;

class SignupProvider extends ChangeNotifier {
  // late final String password;
  late User _userinfo;
  User get userinfo => _userinfo;

  final SignupRepository _signupRepository = SignupRepository();

  Future<String> signup(String id, String password, String name, String email,
      String phone) async {
    final response =
        await _signupRepository.signup(id, password, name, email, phone);

    if (response.statusCode == 200) {
      // _userinfo = User.fromJson(response.body as Map<String, dynamic>);
      notifyListeners();
      print(userinfo);
      print(userinfo.runtimeType);
      return 'success';
    } else {
      return 'error : ${response.statusCode}';
    }
  }
}
