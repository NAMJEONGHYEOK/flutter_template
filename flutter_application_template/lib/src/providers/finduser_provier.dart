import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/repositories/finduserrepository.dart';

class FindUserProvider extends ChangeNotifier {
  String? _id = null;
  String? get id => _id;

  FindUserRepository _findUserRepository = FindUserRepository();

  Future<String> findid_email(String name, String email) async {
    try {
      final response = await _findUserRepository.findid_email(name, email);

      // ignore: unnecessary_null_comparison
      if (response != null) {
        _id = response;
        notifyListeners();
        return 'success';
      } else {
        return 'fail : 사용자 정보를 찾을 수 없습니다';
      }
    } catch (e) {
      print('Error occurred: $e');
      return e.toString();
    }
  }

  Future<String> findid_phone(String name, String phone) async {
    try {
      final response = await _findUserRepository.findid_phone(name, phone);

      if (response != null) {
        _id = response;
        notifyListeners();
        return 'success';
      } else {
        return 'fail : 사용자 정보를 찾을 수 없습니다';
      }
    } catch (e) {
      print('Error occurred: $e');
      return e.toString();
    }
  }
}
