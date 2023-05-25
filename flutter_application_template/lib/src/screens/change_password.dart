import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/widgets/changepassword_widget.dart';
import 'package:flutter_application_template/src/widgets/findpw_widget.dart';

class ChangePassword extends StatelessWidget {
  // const ChangePassword({super.key, title, message});

  // final tempid;
  // ChangePassword({required this.tempid});

  @override
  Widget build(BuildContext context) {
    //
    // final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    // print(args.title);
    // print(args.message);
    // print(tempid);
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 화면 밀림방지
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "비밀번호 변경",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ChangePasswordWidget(),
    );
  }
}
