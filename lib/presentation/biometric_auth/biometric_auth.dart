import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/presentation/biometric_auth/biometric_auth_provider.dart';
import 'package:just_notes/presentation/home_page/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BiometricAuth extends ConsumerWidget {
  static String get routeName => 'biometricAuth';
  static String get routeLocation => '/';
  const BiometricAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(biometricAuthProvider, (previous, next) {
      if(next.loadState == LoadState.success){
        context.replaceNamed(HomePage.routeName);
      }
    });

    return Scaffold(
        backgroundColor: Colors.black38,
        body: ref.watch(biometricAuthProvider).loadState == LoadState.loading?
            const Center(
              child: CircularProgressIndicator(),
            ):
        Center(
            child: GestureDetector(
                onTap: () {
                  ref.read(biometricAuthProvider).checkBiometrics();
                },
                child: const Icon(
                    Icons.fingerprint,
                    color: Colors.white, size: 80
                )
            )
        )
    );
  }
}