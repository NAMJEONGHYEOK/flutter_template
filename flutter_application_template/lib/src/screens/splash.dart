import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthProvider>();

    return FutureBuilder<bool>(
      future: provider.tokenLogin(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터를 불러오는 중이면 로딩 화면을 표시
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.data == true) {
          // 로그인 상태이면 홈 화면으로 이동
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pushNamed(context, 'home');
          });
        } else {
          // 로그인 상태가 아니면 로그인 화면으로 이동
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pushNamed(context, 'login');
          });
        }

        // 데이터를 불러오는 동안 로딩 화면을 표시하므로, 빈 화면을 반환
        return Container();
      },
    );
  }
}
