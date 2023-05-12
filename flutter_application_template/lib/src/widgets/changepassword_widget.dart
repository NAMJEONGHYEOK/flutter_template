//StatefulWidget 으로 작성
import 'package:flutter/material.dart';

class ChangePasswordWidget extends StatefulWidget {
  @override
  ChangePasswordWidgetState createState() => ChangePasswordWidgetState();
}

class ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0), // 컨테이너 페딩추가.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
      ),
    );
  }
}
