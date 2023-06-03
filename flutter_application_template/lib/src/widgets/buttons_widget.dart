// 로그인 페이지 이동 버튼

import 'package:flutter/material.dart';

class GoLoginButton extends StatelessWidget {
  // 로그인 페이지 이동 버튼
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
            // 블럭 효과보이는 버튼
            onPressed: () {
              Navigator.pushNamed(context, 'login');
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
              "로그인",
              style: TextStyle(fontSize: 16),
            )));
  }
}

class Okbutton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: 300,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          // db 통신 if ~else 추가
          Navigator.pushNamed(context, 'login');
        },
        child: Text(
          "확인",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
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
      ),
    );
  }
}

class CancleButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 300,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'login');
        },
        child: Text(
          "취소",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
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
      ),
    );
  }
}
