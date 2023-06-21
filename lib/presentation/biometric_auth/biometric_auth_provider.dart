import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final biometricAuthProvider =
    StateNotifierProvider.autoDispose<BiometricAuthProvider, LoadState>((ref) {
  return BiometricAuthProvider();
});

class BiometricAuthProvider extends StateNotifier<LoadState> {
  BiometricAuthProvider() : super(LoadState.empty);

  LocalAuthentication auth = LocalAuthentication();

  Future<void> checkBiometrics() async {
    state = LoadState.success;
    // try {
    //   state = LoadState.loading;
    //   final bool canCheckBiometrics = await auth.canCheckBiometrics;
    //   if(canCheckBiometrics){
    //     await authenticate();
    //   }
    // } on PlatformException catch (e) {
    //   log(e.toString());
    //   state = LoadState.failed;
    // }
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
      if (authenticated) {
        state = LoadState.success;
      } else {
        state = LoadState.failed;
      }
    } on PlatformException {
      return;
    } catch (e) {
      state = LoadState.failed;
    }
  }

  Future<void> cancelAuthentication() async {
    state = LoadState.empty;
    await auth.stopAuthentication();
  }
}

enum LoadState { empty, loading, success, failed }
