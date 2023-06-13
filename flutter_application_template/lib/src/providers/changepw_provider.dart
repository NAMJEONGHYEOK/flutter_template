import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/repositories/changepwrepository.dart';

class ChangePwProvider extends ChangeNotifier {
  final ChangePwRepository _changePwRepository = ChangePwRepository();

  Future<String> changepassword(String id, String password) async {
    final response = await _changePwRepository.changepassword(id, password);

    // ignore: unnecessary_null_comparison
    if (response) {
      return 'success';
    } else {
      return 'fail : 비밀번호 변경 실패';
    }
  }
}
