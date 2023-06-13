import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/alertdialog_provider.dart';
import 'package:flutter_application_template/src/providers/changepw_provider.dart';

import 'package:flutter_application_template/src/providers/userinfo_provider.dart';
import 'package:flutter_application_template/src/widgets/buttons_widget.dart';
import 'package:flutter_application_template/src/widgets/forminputfield_widget.dart';
import 'package:flutter_application_template/src/widgets/textinform_widget.dart';
import 'package:provider/provider.dart';

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
            const TextInformWidget(
                message: "\u2022 8~12자 영문,숫자,특수문자를 사용할 수 있습니다.\n"
                    "\u2022 한글과 공백문자는 사용할 수 없습니다.\n"
                    "\u2022 영문 대소문자를 구분하거나 꼭 확인해주세요.\n"
                    "\u2022 아이디와 동일하게 설정할 수 없습니다.\n"
                    "\u2022 같은 문자의 반복 또는 쉬운 비밀번호는 사용하지 마세요.\n",
                textAlign: TextAlign.left), // title 글씨
            _inputform(context),
            _changepwbutton(context),
            Okbutton('login'),
            CancleButton('login')
            // GoLoginButton()
          ],
        ));
  }

  Widget _inputform(BuildContext context) {
    String? _id = context.read<UserInfoProvider>().userInfo!.id;
    // print(userid.toString());
    return Form(
        key: _aformKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            Password.withId(_passwordController, _focusNodepassword, _id),
            RePassword(_repasswordController, _focusNoderepassword,
                _passwordController)
          ],
        ));
  }

  Widget _changepwbutton(BuildContext context) {
    String? _id = context.read<UserInfoProvider>().userInfo!.id;
    return ElevatedButton(
      // 블럭 효과보이는 버튼
      onPressed: () async {
        _aformKey.currentState!.save();
        if (_passwordController.text.isEmpty) {
          _focusNodepassword.requestFocus();
        } else if (_repasswordController.text.isEmpty) {
          _focusNoderepassword.requestFocus();
        } else if (!_aformKey.currentState!.validate()) {
        } else {
          var result = await context
              .read<ChangePwProvider>()
              .changepassword(_id!, _passwordController.text);
          if (result == 'success') {
            context
                .read<AlertDialogProvider>()
                .globalshowDialog(context, result);
            Navigator.pushNamed(context, 'login');
          } else {
            context
                .read<AlertDialogProvider>()
                .globalshowDialog(context, result);
          }
        }
      },
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
      child: Text(
        "비밀번호 변경",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
