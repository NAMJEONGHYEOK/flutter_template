import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/screens/change_password.dart';
import 'package:flutter_application_template/src/screens/find_id_result.dart';
import 'package:flutter_application_template/src/screens/find_user.dart';
import 'package:flutter_application_template/src/screens/signup.dart';
import 'package:flutter_application_template/src/screens/splash.dart';
import 'package:flutter_application_template/src/screens/login.dart';
import 'package:flutter_application_template/src/screens/home.dart';
import 'package:flutter_application_template/src/screens/find_pw.dart';
import 'package:flutter_application_template/src/widgets/findpw_widget.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'splash':
        return MaterialPageRoute(builder: (_) => Splash());
      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
      case 'home':
        return MaterialPageRoute(builder: (_) => Home());
      case 'signup':
        return MaterialPageRoute(builder: (_) => SignUp());
      case 'finduser':
        return MaterialPageRoute(builder: (_) => FindUser());
      case 'findidresult':
        return MaterialPageRoute(builder: (_) => FindIdResult());
      case 'changepassword':
        return MaterialPageRoute(
            builder: (context) => ChangePassword(), settings: settings);
      case 'findpw':
        return MaterialPageRoute(builder: (context) => FindPw());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(child: Text("${settings.name} 페이지를 찾을 수 없습니다.")),
          );
        });
    }
  }
}
