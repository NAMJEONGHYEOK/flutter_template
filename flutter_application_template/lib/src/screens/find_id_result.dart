import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/widgets/findidresult_widget.dart';

class FindIdResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // 뒤로가기시 이벤트 작동
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
          body: FindIdResultWidget(),
        ),
        onWillPop: () {
          return Future(() => false);
        } //뒤로가기 막음,
        );
  }
}
