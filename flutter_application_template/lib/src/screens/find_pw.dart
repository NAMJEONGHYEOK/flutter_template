import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/findpw_provider.dart';
import 'package:flutter_application_template/src/widgets/findpw_widget.dart';
import 'package:provider/provider.dart';

class FindPw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FindPwProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드 화면 밀림방지
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            "비밀번호 찾기",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: FindPwWidget(),
      ),
    );
  }
}
