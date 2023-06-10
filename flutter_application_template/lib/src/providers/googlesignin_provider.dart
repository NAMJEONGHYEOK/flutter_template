import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  late GoogleSignIn _googleSignIn;
  late GoogleSignInAccount? _googleUser;

  GoogleSignInAccount? get googleUser => _googleUser;

  GoogleSignInProvider() {
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'profile',
        'openid'

        // 다른 필요한 스코프도 여기에 추가할 수 있습니다.
      ],
    );
  }

  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      _googleUser = googleUser;
      print("test");
      print(_googleUser!.email);
      print(_googleUser!.displayName);
      print(_googleUser!.id);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> googleLogout() async {
    try {
      await _googleSignIn.disconnect();
      _googleUser = null;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
