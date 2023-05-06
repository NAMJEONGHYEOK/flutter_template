import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/login_provider.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      if (context.read<AuthProvider>().isLoggedIn) {
        Navigator.pushNamed(context, 'home');
      } else {
        Navigator.pushNamed(context, 'login');
      }
    });

    return Material(
      child: Center(
          child: FlutterLogo(
        size: 100,
      )),
    );
  }
}
