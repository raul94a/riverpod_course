import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_course_preview/views/screens/login/login_screen.dart';
import 'package:riverpod_course_preview/views/styles/colors.dart';

// esto es para el futuro! para no guardar el token en las prefs
// y para acceder al token desde cualquier lugar
// mientras tanto, lo que vamos a ahcer es usar la reactividad!
// (de riverpod)
final serviceLocator = GetIt.instance; // GetIt.I is also valid
void setUp() {
  serviceLocator.registerSingleton<String>('', instanceName: 'token');
  
}

void main() {
  setUp();
  runApp(const ProviderScope(child: MainApp()));
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
