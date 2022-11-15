import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthProvider extends ChangeNotifier {

  LocalAuthentication auth = LocalAuthentication();
  bool isAuthenticating = false;
  bool authenticated = false;

  Future<void> checkBiometrics() async {
    try {
      final bool canCheckBiometrics = await auth.canCheckBiometrics;
      if(canCheckBiometrics){
        await authenticate();
      }
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  Future<void> authenticate() async {
    try {
      isAuthenticating = true;
      authenticated = await auth.authenticate(
        localizedReason: 'Đăng nhập SNote bằng sinh trắc học',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      isAuthenticating = false;
    } on PlatformException catch (e) {
      isAuthenticating = false;
      return;
    }
    notifyListeners();
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    isAuthenticating = false;
    notifyListeners();
  }

}