import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/screens/change_password.dart';
import 'package:flutter_application_template/src/widgets/findpw_widget.dart';
import 'package:flutter_application_template/src/widgets/gologinbutton_widget.dart';

class ChangePasswordWidget extends StatefulWidget {
  @override
  ChangePasswordWidgetState createState() => ChangePasswordWidgetState();
}

class ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final _aformKey = GlobalKey<FormState>();
  final FocusNode _focusNoderepassword = FocusNode();
  final FocusNode _focusNodepassword = FocusNode();
  final _repasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _repasswordVisible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNoderepassword.dispose();
    _focusNodepassword.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // 기본 컨테이너 단위로 묶어서
        padding: const EdgeInsets.all(15.0), // 컨테이너 페딩추가.
        constraints: BoxConstraints(minWidth: 500),
        child: Column(
          // childe 로 컬럼형태의 위젯배열 올리고
          mainAxisAlignment: MainAxisAlignment.start, // 주축 가운데 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 횡축 가운데 정렬

          children: <Widget>[
            // 컬럼 리스트로 각각의 위젯 출력
            _topLineText(context), // title 글씨
            _inputform(context),
            _okbutton(),
            _canclebutton()
            // GoLoginButton()
          ],
        ));
  }

  Widget _topLineText(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 50, bottom: 50),
      width: 500,
      child: const Text(
        "\u2022 8~12자 영문,숫자,특수문자를 사용할 수 있습니다.\n"
        "\u2022 한글과 공백문자는 사용할 수 없습니다.\n"
        "\u2022 영문 대소문자를 구분하거나 꼭 확인해주세요.\n"
        "\u2022 아이디와 동일하게 설정할 수 없습니다.\n"
        "\u2022 같은 문자의 반복 또는 쉬운 비밀번호는 사용하지 마세요.\n",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _inputform(BuildContext context) {
    // print(userid.toString());
    return Form(
        key: _aformKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: TextFormField(
                focusNode: _focusNodepassword,
                validator: (password) {
                  if (password!.isEmpty) {
                    return "새로운 비밀번호를 입력해주세요.";
                  } else if (!RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$')
                      .hasMatch(password)) {
                    return '특수문자,대문자,숫자를 8자 이상 15자 이내로 작성해주세요.';
                  }
                  return null;
                },
                keyboardType: TextInputType.text, // id text형으로 입력받기
                autocorrect: false, //자동완성 끄기.
                autofocus: false, // 자동 초점설정 끄기
                controller: _passwordController,
                onSaved: (value) => _passwordController.text = value!.trim(),
                style: const TextStyle(fontSize: 15), //글자입,출력 크기조정
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 12, color: Colors.red),
                  filled: true, // 뒷 배경 색채우기
                  fillColor: Colors.white,
                  labelText: 'new PASSWORD',
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 20, maxHeight: 20),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                  ),
                  suffixIcon: IconButton(
                    icon: _passwordVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),

                  hintText: '비밀번호 입력',
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
                obscureText: !_passwordVisible, // 비밀번호 안보이게 처리.
              ),
            ),
            Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: TextFormField(
                validator: (repassword) {
                  if (repassword!.isEmpty) {
                    // 위 입력과 동일한지 검사필요
                    return "새로운 패스워드를 입력해 주세요.";
                  } else if (repassword != _passwordController.text) {
                    return "비밀번호가 일치하지 않습니다";
                  }
                  return null;
                },
                focusNode: _focusNoderepassword,
                autocorrect: false,
                autofocus: false,
                controller: _repasswordController,
                onSaved: (value) => _passwordController.text = value!.trim(),
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 12, color: Colors.red),
                  filled: true, // 뒷 배경 색채우기
                  fillColor: Colors.white,
                  labelText: 're new PASSWORD',
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 20, maxHeight: 20),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                  ),
                  suffixIcon: IconButton(
                    icon: _repasswordVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        _repasswordVisible = !_repasswordVisible;
                      });
                    },
                  ),
                  hintText: '비밀번호 입력',
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
                obscureText: !_repasswordVisible, // 비밀번호 안보이게 처리.
              ),
            )
          ],
        ));
  }

  Widget _okbutton() {
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

  Widget _canclebutton() {
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
