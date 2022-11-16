import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final biometricAuthProvider = ChangeNotifierProvider.autoDispose<BiometricAuthProvider>((ref) => BiometricAuthProvider());

class BiometricAuthProvider extends ChangeNotifier {

  LocalAuthentication auth = LocalAuthentication();
  LoadState loadState = LoadState.empty;

  Future<void> checkBiometrics() async {
    try {
      loadState = LoadState.loading;
      notifyListeners();
      final bool canCheckBiometrics = await auth.canCheckBiometrics;
      if(canCheckBiometrics){
        await authenticate();
      }
    } on PlatformException catch (e) {
      log(e.toString());
      loadState = LoadState.failed;
      notifyListeners();
    }
  }

  Future<void> authenticate() async {
    try {
      final bool authenticated = await auth.authenticate(
        localizedReason: 'Đăng nhập SNote bằng sinh trắc học',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if(authenticated){
        loadState = LoadState.success;
      } else {
        loadState = LoadState.failed;
      }
    } on PlatformException catch (e) {
      return;
    } catch (e){
      loadState = LoadState.failed;
    }
    notifyListeners();

  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    notifyListeners();
  }
}

enum LoadState {
  empty, loading, success, failed
}