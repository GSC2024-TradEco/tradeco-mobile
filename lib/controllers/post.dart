import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';

class PostController {
  Future<List<dynamic>?> getAllPosts(String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.postEndpoints.findAll);

    try {
      final http.Response response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data;
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> createOnePost(
      String title, String description, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.postEndpoints.createOne);
    final Map<String, String> body = {
      'title': title,
      'description': description
    };
    try {
      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        Map<String, dynamic> post = jsonResponse['data'];
        return post;
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
