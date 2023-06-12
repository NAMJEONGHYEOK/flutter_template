//StatefulWidget 으로 작성

import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/signup_provider.dart';
import 'package:flutter_application_template/src/widgets/forminputfield_widget.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  @override
  SignUpWidgetState createState() => SignUpWidgetState();
}

class SignUpWidgetState extends State<SignUpWidget> {
  final _formkey = GlobalKey<FormState>();
  final FocusNode _focusNodeid = FocusNode();
  final FocusNode _focusNodename = FocusNode();
  final FocusNode _focusNodeemail = FocusNode();
  final FocusNode _focusNodephone = FocusNode();
  final FocusNode _focusNoderepassword = FocusNode();
  final FocusNode _focusNodepassword = FocusNode();
  final _idController = TextEditingController();
  final _repasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isenabledbtn = false;
  bool _isAllchecked = false;
  bool _isuserchecked = false;
  bool _isprivacychecked = false;
  bool _islocatechecked = false;
  bool _ismarketingchecked = false;
  bool _isagechecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0), // 컨테이너 페딩추가.
          margin: const EdgeInsets.all(10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _titletext(),
              _signupinputform(context, _formkey)
            ],
          ),
        ),
        const Spacer(), // 버튼을 최하단에 정렬하기 위해 Spacer 추가
        _signupbutton()
      ],
    );
  }

  Widget _titletext() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: const Text("회원가입",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 26,
            color: Colors.black,
          )),
    );
  }

  Widget _signupinputform(BuildContext context, _formkey) {
    return Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _inputtitletext("아이디"),
            Id(_idController, _focusNodeid),
            _inputtitletext("비밀번호"),
            Password(_passwordController, _focusNodepassword),
            _inputtitletext("비밀번호 확인"),
            RePassword(_repasswordController, _focusNoderepassword,
                _passwordController),
            _inputtitletext("이름"),
            Name(_nameController, _focusNodename),
            _inputtitletext("이메일"),
            Email(_emailController, _focusNodeemail),
            _inputtitletext("휴대폰 번호"),
            Phone(_phoneController, _focusNodephone),
            _policyagree()
          ],
        ));
  }

  Widget _inputtitletext(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 9),
      margin: const EdgeInsets.only(left: 6),
      child: Text(
        "$title *",
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _policyagree() {
    return Container(
      padding: const EdgeInsets.only(left: 9),
      child: Column(children: [
        CheckboxListTile(
          title: Text(
            '아래 약관에 모두 동의합니다',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          activeColor: Colors.deepOrangeAccent,
          checkColor: Colors.black,
          controlAffinity: ListTileControlAffinity.leading,
          value: _isAllchecked,
          onChanged: (value) => setState(() {
            _isenabledbtn = value!;
            _isAllchecked = value;
            _islocatechecked = value;
            _ismarketingchecked = value;
            _isprivacychecked = value;
            _isuserchecked = value;
            _isagechecked = value;
          }),
        ),
        CheckboxListTile(
          title: Text('진구앱 이용약관 동의 (필수)', style: TextStyle(fontSize: 14)),
          activeColor: Colors.deepOrangeAccent,
          checkColor: Colors.black,
          controlAffinity: ListTileControlAffinity.leading,
          value: _isuserchecked,
          onChanged: (value) => setState(() {
            _isuserchecked = value!;
            checklist();
          }),
        ),
        CheckboxListTile(
          title: Text('개인정보 처리방침 동의 (필수)', style: TextStyle(fontSize: 14)),
          activeColor: Colors.deepOrangeAccent,
          checkColor: Colors.black,
          controlAffinity: ListTileControlAffinity.leading,
          value: _isprivacychecked,
          onChanged: (value) => setState(() {
            _isprivacychecked = value!;
            checklist();
          }),
        ),
        CheckboxListTile(
          title: Text('위치정보 이용 약관 동의 (필수)', style: TextStyle(fontSize: 14)),
          activeColor: Colors.deepOrangeAccent,
          checkColor: Colors.black,
          controlAffinity: ListTileControlAffinity.leading,
          value: _islocatechecked,
          onChanged: (value) => setState(() {
            _islocatechecked = value!;
            checklist();
          }),
        ),
        CheckboxListTile(
          title: Text('만 14세이상임에 동의 (필수) ', style: TextStyle(fontSize: 14)),
          activeColor: Colors.deepOrangeAccent,
          checkColor: Colors.black,
          controlAffinity: ListTileControlAffinity.leading,
          value: _isagechecked,
          onChanged: (value) => setState(() {
            _isagechecked = value!;
            checklist();
          }),
        ),
        CheckboxListTile(
          title: Text('마케팅 정보 수신 동의 (선택)', style: TextStyle(fontSize: 14)),
          activeColor: Colors.deepOrangeAccent,
          checkColor: Colors.black,
          controlAffinity: ListTileControlAffinity.leading,
          value: _ismarketingchecked,
          onChanged: (value) => setState(() {
            _ismarketingchecked = value!;
            checklist();
          }),
        ),
      ]),
    );
  }

  Widget _signupbutton() {
    final signupProvider = context.read<SignupProvider>();
    return SizedBox(
      width: double.infinity, // 버튼이 화면 전체 너비를 차지하도록 설정
      height: 60,
      child: ElevatedButton(
        onPressed: !_isenabledbtn
            ? null
            : () {
                _formkey.currentState!.validate();
                _formkey.currentState!.save();
                if (_idController.text.isEmpty) {
                  _focusNodeid.requestFocus();
                } else if (_passwordController.text.isEmpty) {
                  _focusNodepassword.requestFocus();
                } else if (_repasswordController.text.isEmpty) {
                  _focusNoderepassword.requestFocus();
                } else if (_emailController.text.isEmpty) {
                  _focusNodeemail.requestFocus();
                } else if (_nameController.text.isEmpty) {
                  _focusNodename.requestFocus();
                } else if (_phoneController.text.isEmpty) {
                  _focusNodephone.requestFocus();
                } else {
                  // 전부 이상없는경우 진행
                  signupProvider.signup(
                      _idController.text,
                      _passwordController.text,
                      _nameController.text,
                      _emailController.text,
                      _phoneController.text);
                  // print(signupProvider.userinfo.name);
                  Navigator.pushNamed(context, 'signupresult');
                }
              },
        child: Text('버튼'),
      ),
    );
  }

  checklist() {
    if (_isagechecked == true &&
        _isuserchecked == true &&
        _ismarketingchecked == true &&
        _islocatechecked == true &&
        _isprivacychecked == true) {
      _isAllchecked = true;
      _isenabledbtn = true;
    } else if (_isagechecked == true &&
        _isuserchecked == true &&
        _islocatechecked == true &&
        _isprivacychecked == true) {
      _isenabledbtn = true;
      _isAllchecked = false;
    } else {
      _isenabledbtn = false;
      _isAllchecked = false;
    }
  }
}
