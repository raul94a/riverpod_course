import 'package:flutter/material.dart';
import 'package:riverpod_course_preview/views/screens/login/widgets/login_card.dart';
import 'package:riverpod_course_preview/views/screens/login/widgets/screen_background_image.dart';
import 'package:riverpod_course_preview/views/styles/colors.dart';

final mainTextColor = lightColorScheme.onPrimary;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ScreenBackground(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginCard(),
              ],
            )),
      ),
    );
  }
}
