// 이거 입력해야 기본위젯 사용가능
import 'package:flutter/material.dart';

var theme = ThemeData(
  primarySwatch: Colors.pink,
  primaryColor: Colors.pink,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 1, // 그림자 정도
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
    actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
  ),
);
