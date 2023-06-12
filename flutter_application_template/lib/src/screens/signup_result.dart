import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/signup_provider.dart';
import 'package:flutter_application_template/src/widgets/signupresult_widget.dart';
import 'package:provider/provider.dart';

class SignupResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignupProvider>(
        create: (_) => SignupProvider(),
        child: WillPopScope(
            // 뒤로가기시 이벤트 작동
            child: Scaffold(
              resizeToAvoidBottomInset: false, // 키보드 화면 밀림방지
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: const Text(
                  "회원가입",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
              ),
              body: SignupResultWidget(),
            ),
            onWillPop: () {
              return Future(() => false);
            } //뒤로가기 막음,
            ));
  }
}
