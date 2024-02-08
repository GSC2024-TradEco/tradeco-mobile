import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';

class UserController {
  Future<bool> registerUser(
      String displayName, String email, String password) async {
    final Uri uri = Uri.parse(API.baseUrl + API.authEndpoints.register);
    final Map<String, dynamic> requestData = {
      'displayName': displayName,
      'email': email,
      'password': password,
    };

    try {
      final http.Response response = await http.post(
        uri,
        body: jsonEncode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // Registration successful
        return true;
      } else {
        // Registration failed
        print('Error registering user: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any network errors
      print('Network error during registration: $e');
      return false;
    }
  }
}
