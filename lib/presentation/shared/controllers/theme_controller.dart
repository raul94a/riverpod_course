import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemeController());

class ThemeController with ChangeNotifier {
  bool light = true;

  void changeStatus() {
    light = !light;
    notifyListeners();
  }
}
