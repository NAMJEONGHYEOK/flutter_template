import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/signup_provider.dart';
import 'package:flutter_application_template/src/widgets/signup_widget.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignupProvider>(
      create: (_) => SignupProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드 화면 밀림방지
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          // title: const Text(
          //   "회원가입",
          //   style: TextStyle(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 20,
          //     color: Colors.black,
          //   ),
          // ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: SignUpWidget(),
      ),
    );
  }
}
