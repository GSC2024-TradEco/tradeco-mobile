import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';
import 'package:zero_waste_application/models/user.dart';

class UserController {
  Future<User?> updateInstagram(String instagram, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.userEndpoints.updateInstagram);
    Map<String, String> body = {'waste ': instagram};

    try {
      final http.Response response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        User user = User.fromJson(jsonResponse['body']);
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<User?> updateLocation(
      double latitude, double longitude, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.userEndpoints.updateLocation);
    Map<String, double> body = {'latitude': latitude, 'longitude': longitude};

    try {
      final http.Response response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        User user = User.fromJson(jsonResponse['body']);
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteOneUser(String token) async {
    final Uri uri =
        Uri.parse(API.baseUrl + API.userEndpoints.deleteOne);

    try {
      final http.Response response = await http.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
