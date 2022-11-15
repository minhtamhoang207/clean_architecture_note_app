import 'package:flutter/material.dart';
import 'package:just_notes/presentation/home_page.dart';
import 'package:provider/provider.dart';

import 'biometric_auth_provider.dart';

class BiometricAuth extends StatelessWidget {
  const BiometricAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BiometricAuthProvider(),
        child: const BiometricAuthPage()
    );
  }
}

class BiometricAuthPage extends StatelessWidget {
  const BiometricAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool authenticated = Provider.of<BiometricAuthProvider>(context).authenticated;
    if(authenticated){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Consumer<BiometricAuthProvider>(
          builder: (context, state, child){
        return Center(
          child: GestureDetector(
              onLongPress: ()=> state.checkBiometrics(),
              child: const Icon(Icons.fingerprint, color: Colors.white, size: 80))
        );
      }),
    );
  }
}

