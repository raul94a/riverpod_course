// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/presentation/screens/home/home_screen.dart';
import 'package:riverpod_course_preview/presentation/shared/controllers/auth_controller.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  @override
  void initState() {
    usernameController.text = 'lgronaverp';
    passwordController.text = '4a1dAKDv9KB9';

    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LoginForm(
                usernameController: usernameController,
                passwordController: passwordController),
            _LoginButton(
              usernameController: usernameController,
              passwordController: passwordController,
            )
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              hintText: 'username',
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0))),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: true,
          controller: passwordController,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              hintText: '**********',
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0))),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class _LoginButton extends ConsumerStatefulWidget {
  const _LoginButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  ConsumerState<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends ConsumerState<_LoginButton> {
  bool loading = false;
  void changeLoadingStatus() => setState(() => loading = !loading);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        key: widget.key,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => const Color.fromARGB(225, 105, 76, 174)),
            fixedSize: MaterialStateProperty.resolveWith(
                (states) => Size(width * 0.98, 50)),
            shape: MaterialStateProperty.resolveWith((states) =>
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)))),
        onPressed: loading
            ? null
            : () async {
                changeLoadingStatus();
                try {
                  await ref.read(authProvider.notifier).login(
                      widget.usernameController.text,
                      widget.passwordController.text);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const HomeScreen()));
                } catch (err) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('$err')));
                } finally {
                  changeLoadingStatus();
                }
              },
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text('Login'));
  }
}
