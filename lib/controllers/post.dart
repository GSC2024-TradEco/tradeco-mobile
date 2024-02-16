import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';
import 'package:zero_waste_application/models/post.dart';

class PostController {
  Future<List<Post>?> getAllPosts(String token) async {
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
        List<dynamic> jsonResponse = json.decode(response.body);
        List<Post> posts =
            jsonResponse.map((json) => Post.fromJson(json)).toList();
        return posts;
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Post?> createOnePost(
      String title, String description, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.postEndpoints.createOne);
    Map<String, String> body = {'title ': title, 'description': description};

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
        Post post = Post.fromJson(jsonResponse['data']);
        return post;
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
