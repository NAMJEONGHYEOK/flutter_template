import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/widgets/home_widget.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 화면 밀림방지
      appBar: AppBar(),
      body: const Home_widget(),
    );
  }
}
