import 'package:flutter/material.dart';
import 'package:riverpod_course_preview/views/screens/login/login_screen.dart';
import 'package:riverpod_course_preview/views/styles/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: lightColorScheme),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
