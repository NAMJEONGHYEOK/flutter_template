import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/widgets/forminputfield_widget.dart';

class FindPwWidget extends StatefulWidget {
  @override
  FindPwWidgetState createState() => FindPwWidgetState();
}

class FindPwWidgetState extends State<FindPwWidget> {
  final _passfindformKey = GlobalKey<FormState>();
  final FocusNode _focusNodename = FocusNode();
  final FocusNode _focusNodeemail = FocusNode();
  final FocusNode _focusNodephone = FocusNode();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _autovalidateMode = AutovalidateMode.disabled;
    _focusNodename.dispose();
    _focusNodeemail.dispose();
    _focusNodephone.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0), // 컨테이너 페딩추가.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _topLineText(context),
          _inputformpassword(context),
          _changepassoword(context),
          _loginpage(context)
        ],
      ),
    );
  }

  Widget _topLineText(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 50, bottom: 50),
      width: 400,
      child: const Text(
        "새 비밀번호를 등록해주세요.",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
    );
  }

  // textformfield - onChange에서 error 확인 후 setState 로 vaildator에 전달하면 실시간 유효성 검사가능
  Widget _inputformpassword(BuildContext context) {
    return Form(
        key: _passfindformKey,
        autovalidateMode: _autovalidateMode,
        child: Column(children: [
          Name(_nameController, _focusNodename),
          Email(_emailController, _focusNodeemail),
          Phone(_phoneController, _focusNodephone)
        ]));
  }

  // 비밀번호 변경하는 버튼
  Widget _changepassoword(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
            // 블럭 효과보이는 버튼
            onPressed: () {
              _passfindformKey.currentState!.validate();
              _passfindformKey.currentState!.save();
              //이름이 비었을경우
              if (_nameController.text.isEmpty) {
                _focusNodename.requestFocus();
              }
              //email이 비었을 경우
              else if (_emailController.text.isEmpty) {
                _focusNodeemail.requestFocus();
              } else if (_phoneController.text.isEmpty) {
                _focusNodephone.requestFocus();
              }
              // if~else 추가 필요

              Navigator.pushNamed(
                context,
                'changepassword',
              );
              // arguments: _nameController.text);
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

  // 로그인 페이지 이동 버튼
  Widget _loginpage(BuildContext context) {
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
