import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/core/util/app_colors.dart';
import 'package:just_notes/presentation/biometric_auth/biometric_auth_provider.dart';
import 'package:just_notes/presentation/home_page/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BiometricAuth extends ConsumerWidget {
  static String get routeName => 'biometricAuth';
  static String get routeLocation => '/';

  static const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.black,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: AppColors.black
  );
  const BiometricAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    ref.listen(biometricAuthProvider, (previous, next) {
      if(next == LoadState.success){
        context.replaceNamed(HomePage.routeName);
      }
    });
    final state = ref.watch(biometricAuthProvider);

    return Scaffold(
        backgroundColor: AppColors.black,
        body: state == LoadState.loading?
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.greenSheen,
              ),
            ):
        Center(
            child: GestureDetector(
                onTap: () =>
                    ref.read(biometricAuthProvider.notifier).checkBiometrics(),
                child: const Icon(
                    Icons.fingerprint,
                    color: Colors.white, size: 80
                )
            )
        )
    );
  }
}
