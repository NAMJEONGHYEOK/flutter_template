import 'package:flutter/material.dart';

class FindUserWidget extends StatefulWidget {
  @override
  FindUserWidgetState createState() => FindUserWidgetState();
}

class FindUserWidgetState extends State<FindUserWidget>
    with TickerProviderStateMixin {
  // state 선언
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNodeid = FocusNode();
  final FocusNode _focusNodepassword = FocusNode();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: const [
                Text(
                  "이메일 인증",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "휴대폰 인증",
                  style: TextStyle(fontSize: 20),
                )
              ],
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [_tabPagefirst(context), _tabPagesecond(context)],
            ))
          ],
        ));
  }

  Widget _tabPagefirst(BuildContext context) {
    return Container(
      child: Column(children: [
        _topLineText(context),
        _inputform_email(context),
        _buildSubmitButton(context)
      ]),
    );
  }

  Widget _tabPagesecond(BuildContext context) {
    return Column(children: [
      _topLineText(context),
      _inputform_phone(context),
      _buildSubmitButton(context)
    ]);
  }

  Widget _topLineText(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 50, bottom: 50),
      width: 400,
      child: const Text(
        "회원가입 시 등록한 정보로 인증을 통해 아이디를 찾거나 패스워드를 변경할 수 있습니다.",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _inputform_email(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: TextFormField(
              focusNode: _focusNodeid,
              validator: (id) {
                if (id!.isEmpty) {
                  return "이름을 입력해 주세요.";
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
                validator: (password) {
                  if (password!.isEmpty) {
                    return "email를 입력해 주세요.";
                  }
                  return null;
                },
                focusNode: _focusNodepassword,
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
        ]));
  }

  Widget _inputform_phone(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: TextFormField(
              focusNode: _focusNodeid,
              validator: (id) {
                if (id!.isEmpty) {
                  return "이름을 입력해 주세요.";
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
                validator: (password) {
                  if (password!.isEmpty) {
                    return "휴대폰 번호를 입력해 주세요.";
                  }
                  return null;
                },
                focusNode: _focusNodepassword,
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
              //email이 비었을 경우
              else if (_emailController.text.isEmpty) {
                _focusNodepassword.requestFocus();
              } else if (!_formKey.currentState!.validate()) {
                // 유효성에서 걸릴경우 state변경 후 메세지 출력
                setState(() {
                  _autovalidateMode = AutovalidateMode.always;
                });
              }
              //입력칸이 전부 입려된 경우. 로그인 함수로 일치, 불일치 실행.
              else {
                // if (await context
                //     .read<AuthProvider>()
                //     .login(_idController.text, _passwordController.text)) {
                //   Navigator.pushNamed(context, 'home');
                // } else {
                //   _showDialog(context, "로그인 실패");
                // }
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
              "아이디 찾기",
              style: TextStyle(fontSize: 16),
            )));
  }

  // 비밀번호 변경하러가는 버튼
  Widget _changepassoword(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
            // 블럭 효과보이는 버튼
            onPressed: () {},
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
