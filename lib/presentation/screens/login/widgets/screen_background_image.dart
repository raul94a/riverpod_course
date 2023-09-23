import 'package:flutter/material.dart';
class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        key: key,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bck.jpg'),
                fit: BoxFit.fitHeight)),
        child: child);
  }
}