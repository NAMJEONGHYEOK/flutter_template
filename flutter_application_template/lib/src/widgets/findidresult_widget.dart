//StatelessWidget 으로 작성

import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/userinfo_provider.dart';
import 'package:flutter_application_template/src/widgets/buttons_widget.dart';
import 'package:provider/provider.dart';

class FindIdResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [_resultid(context), FindPassword(), GoLoginButton()],
    ));
  }

  Widget _resultid(BuildContext context) {
    final findid = context.read<UserInfoProvider>().userInfo!.id;
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Text(
        '\u2022 $findid',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
