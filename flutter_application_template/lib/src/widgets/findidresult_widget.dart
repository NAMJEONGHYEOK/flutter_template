//StatelessWidget 으로 작성

import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/widgets/buttons_widget.dart';

class FindIdResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        _resultid(context),
        _changepassoword(context),
        GoLoginButton()
      ],
    ));
  }

  Widget _resultid(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Text(
        '\u2022 아이디 결과 출력',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  // 비밀번호 변경하러가는 버튼
  Widget _changepassoword(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
            // 블럭 효과보이는 버튼
            onPressed: () {
              Navigator.pushNamed(context, 'changepassword',
                  arguments: 'userid');
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3))),
              foregroundColor: MaterialStateProperty.all(
                //모든 상태에따라 아래 색상표기
                Colors.white, // 글자색
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                // 버튼 상태에따라 색상 변경
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey;
                  } else {
                    return Colors.blue;
                  }
                },
              ),
            ),
            child: const Text(
              "비밀번호 변경",
              style: TextStyle(fontSize: 16),
            )));
  }
}
