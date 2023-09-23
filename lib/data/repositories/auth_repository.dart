import 'dart:convert';

import 'package:riverpod_course_preview/data/api/auth_api.dart';
import 'package:riverpod_course_preview/data/models/user.dart';

class AuthRepository {
  final AuthApi api;
  const AuthRepository(this.api);
  Future<User> login(String username, String password) async {
    //connectivity check!
    final body = jsonEncode({'username': username, 'password': password});
    final user = await api.login(body);
    return User.fromMap(user);
  }
}
