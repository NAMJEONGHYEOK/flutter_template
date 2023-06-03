import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/widgets/forminputfield_widget.dart';

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
  // 화면 전환 에니메이션
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late TabController _tabController;

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
        // _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _pnameController.clear();
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
    _focusNodephone.dispose();
    _tabController.dispose();
    _pnameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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

  // 첫번째 탭 페이지
  Widget _tabPagefirst(BuildContext context) {
    return Container(
      child: Column(children: [
        _topLineText(context),
        _inputform_email(context),
        _findpassoword(context),
        _buildSubmitButton(context)
      ]),
    );
  }

  // 탭 두번째 페이지
  Widget _tabPagesecond(BuildContext context) {
    return Container(
      child: Column(children: [
        _topLineText(context),
        _inputform_phone(context),
        _findpassoword(context),
        _buildSubmitButton(context)
      ]),
    );
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
          Name(_nameController, _focusNodename),
          Email(_emailController, _focusNodeemail),
        ]));
  }

  Widget _inputform_phone(BuildContext context) {
    return Form(
        key: _pformKey,
        autovalidateMode: _autovalidateMode,
        child: Column(children: [
          Name(_nameController, _focusNodename),
          Phone(_phoneController, _focusNodephone)
        ]));
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
            // 블럭 효과보이는 버튼
            onPressed: () {
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
                }
              }
              // 유효성 검사 통과할 경우 provider 로직 실행 후 정상인 경우만 pass
              // if ( ){
              // } else {
              // }
              // Navigator.pushNamed(context, 'findidresult');

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

  // 비밀번호 찾으러가는 버튼
  Widget _findpassoword(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
            // 블럭 효과보이는 버튼
            onPressed: () {
              Navigator.pushNamed(context, 'findpw');
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
              "비밀번호 찾기",
              style: TextStyle(fontSize: 16),
            )));
  }
}
