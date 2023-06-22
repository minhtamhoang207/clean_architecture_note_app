import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/presentation/add_note/add_note.dart';
import 'package:just_notes/presentation/dashboard/dashboard.dart';
import 'package:just_notes/presentation/manage_money/manage_money.dart';
import 'package:just_notes/presentation/note/note.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: Dashboard.routeName,
        path: Dashboard.routeLocation,
        builder: (BuildContext context, GoRouterState state) {
          return const Dashboard();
        },
      ),
      GoRoute(
        name: NoteView.routeName,
        path: NoteView.routeLocation,
        builder: (BuildContext context, GoRouterState state) {
          return const NoteView();
        },
      ),
      GoRoute(
        name: ManageMoney.routeName,
        path: ManageMoney.routeLocation,
        builder: (BuildContext context, GoRouterState state) {
          return const ManageMoney();
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
