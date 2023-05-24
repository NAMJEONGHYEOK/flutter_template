import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FindPwWidget extends StatefulWidget {
  @override
  FindPwWidgetState createState() => FindPwWidgetState();
}

class FindPwWidgetState extends State<FindPwWidget> {
  final _pformKey = GlobalKey<FormState>();
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
        key: _pformKey,
        autovalidateMode: _autovalidateMode,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: TextFormField(
              focusNode: _focusNodename,
              validator: (name) {
                if (name!.isEmpty) {
                  return "이름을 입력해 주세요.";
                } else if (!RegExp(r'^[ㄱ-ㅎ|가-힣|a-z|A-Z|\s]+$').hasMatch(name)) {
                  return '한글 또는 영어만 입력 가능합니다';
                }
                return null;
              },
              keyboardType: TextInputType.text, // name text형으로 입력받기
              autocorrect: false, //자동완성 끄기.
              autofocus: true, // 자동 초점설정 끄기
              controller: _nameController,
              onSaved: (value) => _nameController.text = value!.trim(),
              style: const TextStyle(fontSize: 15), //글자입,출력 크기조정
              decoration: InputDecoration(
                filled: true, // 뒷 배경 색채우기
                fillColor: Colors.white,
                labelText: 'NAME',
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 20, maxHeight: 20),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                ),
                hintText: 'name 입력',
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: TextFormField(
                validator: (email) {
                  if (email!.isEmpty) {
                    return "email를 입력해 주세요.";
                  } else if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(email)) {
                    return "email 형식이 아닙니다. email을 입력해 주세요";
                  }
                  return null;
                },
                focusNode: _focusNodeemail,
                autocorrect: false,
                autofocus: false,
                controller: _emailController,
                onSaved: (value) => _emailController.text = value!.trim(),
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 12, color: Colors.red),
                  filled: true, // 뒷 배경 색채우기
                  fillColor: Colors.white,
                  labelText: 'EMAIL',
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 20, maxHeight: 20),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                  ),
                  hintText: 'email 입력',
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
              )),
          Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: TextFormField(
                validator: (phone) {
                  if (phone!.isEmpty) {
                    return "휴대폰 번호를 입력해 주세요.";
                  } else if (!RegExp(
                          r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                      .hasMatch(phone)) {
                    return "-없이 '01012345678' 으로 입력해주세요";
                  } else if (phone.length != 11) {
                    return "010을 포함한 11자리 모두 입력해주세요";
                  }
                  return null;
                },
                focusNode: _focusNodephone,
                autocorrect: false,
                autofocus: false,
                controller: _phoneController,
                onSaved: (value) => _phoneController.text = value!.trim(),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 15),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 11,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 12, color: Colors.red),
                  filled: true, // 뒷 배경 색채우기
                  fillColor: Colors.white,
                  labelText: 'PHONE',
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 20, maxHeight: 20),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                  ),
                  hintText: 'Phone 입력',
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
              )),
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
              _pformKey.currentState!.validate();
              _pformKey.currentState!.save();
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
              Navigator.pushNamed(context, 'changepassword');
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
