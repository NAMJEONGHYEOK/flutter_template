import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_template/src/widgets/forminputfield_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_template/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNodeid = FocusNode();
  final FocusNode _focusNodepassword = FocusNode();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _focusNodeid.dispose();
    _focusNodepassword.dispose();
    _passwordController.dispose();
    _idController.dispose();
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
            _signupline(),
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
            Id(_idController, _focusNodeid),
            Password(_passwordController, _focusNodepassword)
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
                value.autologin(avalue);
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
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'finduser');
              },
              child:
                  Text("Id/Password 찾기", style: TextStyle(color: Colors.grey)))
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
            onPressed: () async {
              _formKey.currentState!.validate();
              _formKey.currentState!.save();
              //id가 비었을경우
              if (_idController.text.isEmpty) {
                _focusNodeid.requestFocus();
              }
              //password가 비었을 경우
              else if (_passwordController.text.isEmpty) {
                _focusNodepassword.requestFocus();
              }
              // else if (!_formKey.currentState!.validate()) {
              //   // 유효성에서 걸릴경우 state변경 후 메세지 출력
              //   setState(() {
              //     _autovalidateMode = AutovalidateMode.always;
              //   });
              // }
              //입력칸이 전부 입려된 경우. 로그인 함수로 일치, 불일치 실행.
              else {
                if (await context
                    .read<AuthProvider>()
                    .login(_idController.text, _passwordController.text)) {
                  Navigator.pushNamed(context, 'home');
                } else {
                  _showDialog(context, "로그인 실패");
                }
//               // ##
//               final authProvider = Provider.of<AuthProvider>(context, listen: false);

// // Access Token 저장
// authProvider.accessToken = 'your_access_token_here';

// // Access Token 삭제
// authProvider.deleteAccessToken();

                // Navigator.pushNamed(context, 'home');

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

  Widget _signupline() {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "아직 회원이 아니신가요?",
            style: TextStyle(color: Colors.grey),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'signup');
              },
              child: const Text(
                "회원가입",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
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
