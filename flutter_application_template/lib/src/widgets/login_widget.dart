import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_template/src/providers/login_provider.dart';
import 'package:provider/provider.dart';

class Login_widget extends StatefulWidget {
  @override
  Login_widgetState createState() => Login_widgetState();
}

class Login_widgetState extends State<Login_widget> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNodeid = FocusNode();
  final FocusNode _focusNodepassword = FocusNode();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _focusNodeid.dispose();
    _focusNodepassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // 기본 컨테이너 단위로 묶어서
        padding: const EdgeInsets.all(15.0), // 컨테이너 페딩추가.

        child: Column(
          // childe 로 컬럼형태의 위젯배열 올리고
          mainAxisAlignment: MainAxisAlignment.start, // 주축 가운데 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 횡축 가운데 정렬

          children: <Widget>[
            // 컬럼 리스트로 각각의 위젯 출력
            _titleText(), // title 글씨
            _inputform(context),
            _findidpassword(context),
            _buildSubmitButton(context),
          ],
        ));
  }

// 타이틀 위젯
  Widget _titleText() {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft, // 200의 중간 왼쪽정렬
      width: double.infinity, // 가로 width 100%
      height: 110,
      child: const Center(
        child: Text(
          "JInGu",
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 50,
            fontWeight: FontWeight.w600, // 타이틀 폰트 굵기 설정.
          ),
        ),
      ),
    );
  }

  Widget _inputform(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: TextFormField(
                focusNode: _focusNodeid,
                validator: (id) {
                  if (id!.isEmpty) {
                    return "id 입력해 주세요.";
                  }
                  return null;
                },
                keyboardType: TextInputType.text, // id text형으로 입력받기
                autocorrect: false, //자동완성 끄기.
                autofocus: false, // 자동 초점설정 끄기
                controller: _idController,
                onSaved: (value) => _idController.text = value!.trim(),
                style: const TextStyle(fontSize: 15), //글자입,출력 크기조정
                decoration: InputDecoration(
                  filled: true, // 뒷 배경 색채우기
                  labelText: 'ID',
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 20, maxHeight: 20),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                  ),
                  hintText: '아이디 입력',
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Consumer<AuthProvider>(
                  builder: (context, isObscure, child) {
                    return TextFormField(
                      validator: (password) {
                        if (password!.isEmpty) {
                          return "password를 입력해 주세요.";
                        }
                        return null;
                      },
                      focusNode: _focusNodepassword,
                      autocorrect: false,
                      autofocus: false,
                      controller: _passwordController,
                      onSaved: (value) =>
                          _passwordController.text = value!.trim(),
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 12, color: Colors.red),
                        filled: true, // 뒷 배경 색채우기
                        labelText: 'PASSWORD',
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
                    );
                  },
                ))
          ],
        ));
  }

//아이디 저장 상태 유무 버튼
  Widget _idCheck() {
    return Row(
      children: <Widget>[
        const Text(
          "자동 로그인",
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 15,
          ),
        ),
        Consumer<AuthProvider>(
          // consumer 이용해서 context를 통해서 value 변수로 값을 주고 받는다.
          builder: (context, value, child) => Switch(
              // 변수 value, 적용범위 child
              onChanged: (bool avalue) {
                value.autologin(autovalue: avalue);

                // provider에 정의된 토글 함수에 변수 isNoti를 대입
              },
              value: value.isAutoLogin),
        ),
      ],
    );
  }

// id password 찾기 위젯
  Widget _findidpassword(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _idCheck(),
          TextButton(onPressed: () {}, child: Text("id/password 찾기"))
        ],
      ),
    );
  }

//로그인 버튼 위젯
  Widget _buildSubmitButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
            // 블럭 효과보이는 버튼
            onPressed: () {
              _formKey.currentState!.validate();
              _formKey.currentState!.save();
              //id가 비었을경우
              if (_idController.text.isEmpty) {
                _focusNodeid.requestFocus();
              }
              //password가 비었을 경우
              else if (_passwordController.text.isEmpty) {
                _focusNodepassword.requestFocus();
              } else if (!_formKey.currentState!.validate()) {
                // 유효성에서 걸릴경우 state변경 후 메세지 출력
                setState(() {
                  _autovalidateMode = AutovalidateMode.always;
                });
              }
              //입력칸이 전부 입려된 경우. 로그인 함수로 일치, 불일치 실행.
              else {
                Navigator.pushNamed(context, 'home');

                // if (!await context
                //     .read<AuthProvider>()
                //     .login(_idController.text, _passwordController.text)) {
                //   _showDialog(context, '존재하지 않는 사용자 정보입니다');
                // } else {
                //   context.read<Loginbutton>().Listener();
                // }
              }

              //아직미처리..
              // String errorMessage = '존재하지 않는 회원 정보입니다.';
              // _showDialog(context, errorMessage);
            }, // alert 경고창 모듈 만들어서
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
              "Login",
              style: TextStyle(fontSize: 16),
            )));
  }

// 팝업창 함수.
  void _showDialog(context, String contents) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          title: new Text("다시 입력해주세요."),
          content: SingleChildScrollView(child: new Text('$contents')),
          actions: <Widget>[
            Container(
              child: TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
