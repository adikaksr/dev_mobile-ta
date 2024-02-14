// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const String _apiUrl = 'https://your-api-url.com';

  Future<Map<String, dynamic>> login(String nimNip, String password) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/login'),
      body: jsonEncode(<String, String>{
        'username': nimNip, // Use 'username' if your API expects 'username'
        'password': password,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}
