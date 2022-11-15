import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/presentation/biometric_auth/biometric_auth.dart';
import 'package:just_notes/presentation/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.dev);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BiometricAuth()
    );
  }
}