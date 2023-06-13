import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/repositories/signuprepository.dart';

class SignupProvider extends ChangeNotifier {
  final SignupRepository _signupRepository = SignupRepository();

  Future<bool> signup(String id, String password, String name, String email,
      String phone, String type) async {
    try {
      final response = await _signupRepository.signup(
          id, password, name, email, phone, type);

      if (response == 'success') {
        return true;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
    return false;
  }
}
