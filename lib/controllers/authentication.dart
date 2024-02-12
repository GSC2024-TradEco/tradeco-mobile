import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';

class AuthController {
  Future<bool> register(
      String displayName, String email, String password) async {
    final Uri uri = Uri.parse(API.baseUrl + API.authEndpoints.register);
    final Map<String, String> body = {
      'displayName': displayName,
      'email': email,
      'password': password,
    };

    try {
      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
