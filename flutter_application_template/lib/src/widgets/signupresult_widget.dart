import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/signup_provider.dart';
import 'package:flutter_application_template/src/providers/userinfo_provider.dart';
import 'package:flutter_application_template/src/widgets/buttons_widget.dart';
import 'package:flutter_application_template/src/widgets/textinform_widget.dart';
import 'package:provider/provider.dart';

class SignupResultWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final user = context.read<UserInfoProvider>().userInfo;

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          TextInformWidget(
              message: "${user?.name}님 회원가입을 축하합니다.",
              textAlign: TextAlign.center),
          GoLoginButton()
        ],
      ),
    );
  }
}
