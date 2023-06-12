import 'package:flutter/material.dart';

class AlertDialogProvider extends ChangeNotifier {
//  저장할 상태 변수 x

  void globalshowDialog(context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          title: const Text("다시 입력해주세요."),
          content: SingleChildScrollView(child: Text(message)),
          actions: <Widget>[
            Container(
              child: TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
