import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';
import 'package:zero_waste_application/models/user.dart';

class UserController {
  Future<User> updateInstagram(String instagram, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.userEndpoints.updateInstagram);
    Map<String, String> body = {'waste ': instagram};

    try {
      final http.Response response = await http.get(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        User user = jsonList.map((json) => User.fromJson(json)).toList();
        return user;
      }
    } catch (e) {
      // Handle any network errors
      print('Error: $e');
    }
  }

  Future<User> updateLocation(
      double latitude, double longitude, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.userEndpoints.updateLocation);
    Map<String, double> body = {'latitude': latitude, 'longitude': longitude};

    try {
      final http.Response response = await http.get(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        User user = jsonList.map((json) => User.fromJson(json)).toList();
        return user;
      }
    } catch (e) {
      // Handle any network errors
      print('Error: $e');
    }
  }
}
