import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FindUserWidget extends StatefulWidget {
  @override
  FindUserWidgetState createState() => FindUserWidgetState();
}

class FindUserWidgetState extends State<FindUserWidget>
    with TickerProviderStateMixin {
  // state 선언
  final _eformKey = GlobalKey<FormState>();
  final _pformKey = GlobalKey<FormState>();
  final FocusNode _focusNodename = FocusNode();
  final FocusNode _focusNodeemail = FocusNode();
  final FocusNode _focusNodephone = FocusNode();
  final _nameController = TextEditingController();
  final _pnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late TabController _tabController;
  int _tabbarIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );

    // TabController의 인덱스 변경 이벤트를 감지하는 리스너 등록
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _pnameController.clear();
        _tabbarIndex = _tabController.index;
        setState(() {
          _autovalidateMode = AutovalidateMode.disabled;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNodename.dispose();
    _focusNodeemail.dispose();
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
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "이메일 인증",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "휴대폰 인증",
                    style: TextStyle(fontSize: 18),
                  ),
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

  // textformfield - onChange에서 error 확인 후 setState 로 vaildator에 전달하면 실시간 유효성 검사가능
  Widget _inputform_email(BuildContext context) {
    return Form(
        key: _eformKey,
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
        ]));
  }

  Widget _inputform_phone(BuildContext context) {
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
              keyboardType: TextInputType.text, // id text형으로 입력받기
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

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
            // 블럭 효과보이는 버튼
            onPressed: () async {
              if (_tabController.index == 0) {
                _eformKey.currentState!.validate();
                _eformKey.currentState!.save();
                //이름이 비었을경우
                if (_nameController.text.isEmpty) {
                  _focusNodename.requestFocus();
                }
                //email이 비었을 경우
                else if (_emailController.text.isEmpty) {
                  _focusNodeemail.requestFocus();
                }
              } else if (_tabController.index == 1) {
                _pformKey.currentState!.validate();
                _pformKey.currentState!.save();
                if (_nameController.text.isEmpty) {
                  _focusNodename.requestFocus();
                }
                //phone이 비었을 경우
                else if (_phoneController.text.isEmpty) {
                  _focusNodephone.requestFocus();
                } else if (!_eformKey.currentState!.validate()) {
                  // 유효성에서 걸릴경우 state변경 후 메세지 출력
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                }
              }
              //
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
