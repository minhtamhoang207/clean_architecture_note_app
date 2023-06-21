import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/presentation/add_note/add_note.dart';
import 'package:just_notes/presentation/biometric_auth/biometric_auth.dart';
import 'package:just_notes/presentation/home_page/home_page.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: BiometricAuth.routeName,
        path: BiometricAuth.routeLocation,
        builder: (BuildContext context, GoRouterState state) {
          return const BiometricAuth();
        },
      ),
      GoRoute(
        name: HomePage.routeName,
        path: HomePage.routeLocation,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        name: AddNote.routeName,
        path: AddNote.routeLocation,
        builder: (BuildContext context, GoRouterState state) {
          return const AddNote();
        },
      ),
    ],
  );
}
