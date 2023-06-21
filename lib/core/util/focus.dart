import 'package:flutter/cupertino.dart';

class AppFocus {
  static void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
