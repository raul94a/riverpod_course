import 'package:flutter_riverpod/flutter_riverpod.dart';

// ESTE ARCHIVO NO EXPLICAR HASTA EL FINAL DEL CURSO

final environmentProvider = Provider((ref) => EnvironmentState());

class EnvironmentState {

  String _baseUrl = '';
  String get baseUrl => _baseUrl;

  EnvironmentState() {
    const env = String.fromEnvironment('env', defaultValue: 'dev');
    if (env == 'prod') {
      _baseUrl = 'https://prod.myhost.com';
    } else {
      _baseUrl = 'https://dev.myhost.com';
    }
  }
}
