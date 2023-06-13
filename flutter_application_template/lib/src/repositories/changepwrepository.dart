import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_template/src/utils/configs.dart' as API_URL;

class ChangePwRepository {
  final String _baseUrl = API_URL.Configs.API_URL;

  Future<bool> changepassword(String id, String password) async {
    print(id);
    print(password);
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/changepassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode(<String, dynamic>{'id': id, 'password': password}),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }
}
