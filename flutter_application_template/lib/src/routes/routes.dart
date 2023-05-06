import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/screens/splash.dart';
import 'package:flutter_application_template/src/screens/login.dart';
import 'package:flutter_application_template/src/screens/home.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'splash':
        return MaterialPageRoute(builder: (_) => Splash());

      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
      case 'home':
        return MaterialPageRoute(builder: (_) => Home());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(child: Text("${settings.name} 페이지를 찾을 수 없습니다.")),
          );
        });
    }
  }
}
