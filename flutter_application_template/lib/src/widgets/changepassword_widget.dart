import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/widgets/buttons_widget.dart';
import 'package:flutter_application_template/src/widgets/forminputfield_widget.dart';

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
            Okbutton(),
            CancleButton()
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
            Password(_passwordController, _focusNodepassword),
            RePassword(_repasswordController, _focusNoderepassword)
          ],
        ));
  }
}
