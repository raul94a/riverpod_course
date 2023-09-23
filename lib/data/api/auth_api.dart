import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class AuthApi {
  Future<Map<String, dynamic>> login(String body) async {
    const url = 'https://dummyjson.com/auth/login';
    final uri = Uri.parse(url);

    try {
      final response = await http.post(uri, body: body);
      final statusCode = response.statusCode;
      if (statusCode == HttpStatus.ok) {
        return jsonDecode(response.body);
      }
      throw Exception('$statusCode: ${response.reasonPhrase}');
    } catch (err) {
      throw Exception('$err');
    }
  }
}
