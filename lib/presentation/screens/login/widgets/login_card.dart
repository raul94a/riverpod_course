import 'package:flutter/material.dart';

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

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        key: key,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => const Color.fromARGB(225, 105, 76, 174)),
            fixedSize: MaterialStateProperty.resolveWith(
                (states) => Size(width * 0.98, 50)),
            shape: MaterialStateProperty.resolveWith((states) =>
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)))),
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const Scaffold(body: SizedBox())));
        },
        child: const Text('Login'));
  }
}
