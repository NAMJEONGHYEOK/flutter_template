import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/repositories/finduserrepository.dart';

class FindUserProvider extends ChangeNotifier {
  FindUserRepository _findUserRepository = FindUserRepository();

  // Future<void> findid_email(String name, String email) async {
  //   final response = _findUserRepository.findid_email(name, email);
  //   response.statuscode
  // }

  Future<String> findid_email(String name, String email) async {
    final response = await _findUserRepository.findid_email(name, email);

    if (response.statusCode == 200) {
      print(response.body);
      return 'success';
    }
    return 'fail';
  }

  Future<String> findid_phone(String name, String phone) async {
    final response = await _findUserRepository.findid_phone(name, phone);

    if (response.statusCode == 200) {
      print(response.body);
      return 'success';
    }
    return 'fail';
  }

  Future<String> findpassword(String id, String name, String phone) async {
    final response = await _findUserRepository.findpassword(id, name, phone);

    if (response.statusCode == 200) {
      print(response.body);
      return 'success';
    }
    return 'fail';
  }
}
