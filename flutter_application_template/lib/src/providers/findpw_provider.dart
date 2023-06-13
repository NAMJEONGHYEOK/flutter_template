import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/repositories/findpwrepository.dart';

class FindPwProvider extends ChangeNotifier {
  FindPwRepository _findPwRepository = FindPwRepository();

  Future<String> findpassword(String id, String name, String phone) async {
    final response = await _findPwRepository.findpassword(id, name, phone);

    if (response != null) {
      return 'success';
    } else {
      return 'fail : 사용자 정보를 찾을 수 없습니다';
    }
  }
}
