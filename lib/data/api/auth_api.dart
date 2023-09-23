import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class AuthApi {
  Future<Map<String, dynamic>> login(String body) async {
    const url = 'https://dummyjson.com/auth/login';
    final uri = Uri.parse(url);

    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};
      
      final response = await http.post(uri, headers: headers, body: body);
      print(body);
      final statusCode = response.statusCode;
      print(statusCode);
      if (statusCode == HttpStatus.ok) {
        return jsonDecode(response.body);
      }
      throw '$statusCode: ${response.reasonPhrase}';
    } catch (err) {
      throw Exception('$err');
    }
  }
}
