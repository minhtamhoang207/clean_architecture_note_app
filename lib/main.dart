import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/core/route/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoute.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
