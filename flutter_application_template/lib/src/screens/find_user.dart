import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/finduser_provier.dart';
import 'package:flutter_application_template/src/widgets/finduser_widget.dart';
import 'package:provider/provider.dart';

class FindUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FindUserProvider>(
      create: (_) => FindUserProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드 화면 밀림방지
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            "아이디 찾기",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: FindUserWidget(),
      ),
    );
  }
}
