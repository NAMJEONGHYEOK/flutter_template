// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// id,paasword,email,name, phone,repassword stateful widget있음

class Email extends StatefulWidget {
  //생성자 변수 생성하여 관리
  final TextEditingController _controller;
  final FocusNode _focusnode;
  Email(this._controller, this._focusnode);

  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(6, 6, 6, 18),
        padding: const EdgeInsets.symmetric(horizontal: 6),
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
          focusNode: widget._focusnode,
          autocorrect: false,
          autofocus: false,
          controller: widget._controller,
          onSaved: (value) => widget._controller.text = value!.trim(),
          keyboardType: TextInputType.emailAddress,
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
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
          ),
        ));
  }
}

class Id extends StatefulWidget {
  final TextEditingController _controller;
  final FocusNode _focusnode;
  Id(this._controller, this._focusnode);
  _IdState createState() => _IdState();
}

class _IdState extends State<Id> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 6, 6, 18),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextFormField(
        focusNode: widget._focusnode,
        validator: (id) {
          if (id!.isEmpty) {
            return "id를 입력해 주세요.";
          }
          return null;
        },
        keyboardType: TextInputType.text, // id text형으로 입력받기
        autocorrect: false, //자동완성 끄기.
        autofocus: true, // 자동 초점설정 끄기
        controller: widget._controller,
        onSaved: (value) => widget._controller.text = value!.trim(),
        style: const TextStyle(fontSize: 15), //글자입,출력 크기조정
        decoration: InputDecoration(
          filled: true, // 뒷 배경 색채우기
          fillColor: Colors.white,
          labelText: 'ID',
          prefixIconConstraints:
              const BoxConstraints(minWidth: 20, maxHeight: 20),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
          ),
          hintText: 'id 입력',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
        ),
      ),
    );
  }
}

class Password extends StatefulWidget {
  final TextEditingController _controller;
  final FocusNode _focusnode;
  bool _passwordVisible = false;

  Password(this._controller, this._focusnode, {super.key});

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 6, 6, 18),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextFormField(
        focusNode: widget._focusnode,
        validator: (password) {
          if (password!.isEmpty) {
            return "비밀번호를 입력해주세요.";
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
        controller: widget._controller,
        onSaved: (value) => widget._controller.text = value!.trim(),
        style: const TextStyle(fontSize: 15), //글자입,출력 크기조정
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 12, color: Colors.red),
          filled: true, // 뒷 배경 색채우기
          fillColor: Colors.white,
          labelText: 'PASSWORD',
          prefixIconConstraints:
              const BoxConstraints(minWidth: 20, maxHeight: 20),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 15, right: 10),
          ),
          suffixIcon: IconButton(
            icon: widget._passwordVisible
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            color: Colors.grey,
            onPressed: () {
              setState(() {
                widget._passwordVisible = !widget._passwordVisible;
              });
            },
          ),

          hintText: '비밀번호 입력',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
        ),
        obscureText: !widget._passwordVisible, // 비밀번호 안보이게 처리.
      ),
    );
  }
}

class RePassword extends StatefulWidget {
  final TextEditingController _controllervalidate;
  final TextEditingController _controller;
  final FocusNode _focusnode;
  late bool _passwordVisible = false;
  RePassword(this._controller, this._focusnode, this._controllervalidate,
      {Key? key})
      : _passwordVisible = false,
        super(key: key);
  // String _message;
  @override
  _RePasswordState createState() => _RePasswordState();
}

class _RePasswordState extends State<RePassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 6, 6, 18),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextFormField(
        validator: (repassword) {
          if (repassword!.isEmpty) {
            // 위 입력과 동일한지 검사필요
            return "비밀번호를 입력해 주세요.";
          } else if (repassword != widget._controllervalidate.text) {
            return "비밀번호가 일치하지 않습니다";
          }
          return null;
        },
        focusNode: widget._focusnode,
        autocorrect: false,
        autofocus: false,
        controller: widget._controller,
        onSaved: (value) => widget._controller.text = value!.trim(),
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 12, color: Colors.red),
          filled: true, // 뒷 배경 색채우기
          fillColor: Colors.white,
          labelText: 'Re PASSWORD',
          prefixIconConstraints:
              const BoxConstraints(minWidth: 20, maxHeight: 20),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
          ),
          suffixIcon: IconButton(
            icon: widget._passwordVisible
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            color: Colors.grey,
            onPressed: () {
              setState(() {
                widget._passwordVisible = !widget._passwordVisible;
              });
            },
          ),
          hintText: '비밀번호 입력',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
        ),
        obscureText: !widget._passwordVisible, // 비밀번호 안보이게 처리.
      ),
    );
  }
}

class Name extends StatefulWidget {
  final TextEditingController _controller;
  final FocusNode _focusnode;
  Name(this._controller, this._focusnode);
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 6, 6, 18),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextFormField(
        focusNode: widget._focusnode,
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
        controller: widget._controller,
        onSaved: (value) => widget._controller.text = value!.trim(),
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
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
        ),
      ),
    );
  }
}

class Phone extends StatefulWidget {
  final TextEditingController _controller;
  final FocusNode _focusnode;
  Phone(this._controller, this._focusnode);
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(6, 6, 6, 18),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: TextFormField(
          validator: (phone) {
            if (phone!.isEmpty) {
              return "휴대폰 번호를 입력해 주세요.";
            } else if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                .hasMatch(phone)) {
              return "-없이 '01012345678' 으로 입력해주세요";
            } else if (phone.length != 11) {
              return "010을 포함한 11자리 모두 입력해주세요";
            }
            return null;
          },
          focusNode: widget._focusnode,
          autocorrect: false,
          autofocus: false,
          controller: widget._controller,
          onSaved: (value) => widget._controller.text = value!.trim(),
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
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
          ),
        ));
  }
}
