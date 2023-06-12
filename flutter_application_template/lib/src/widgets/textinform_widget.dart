import 'package:flutter/material.dart';

class TextInformWidget extends StatelessWidget {
  final String message;
  final TextAlign textAlign;
  const TextInformWidget(
      {super.key, required this.message, required this.textAlign});

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 50, bottom: 50),
      width: 500,
      child: Text(
        message,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        textAlign: textAlign,
      ),
    );
  }
}
