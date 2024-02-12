import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';
import 'package:zero_waste_application/models/project.dart';

class BookmarkController {
  Future<List<Project>> getAllBookmarks(String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.bookmarkEndpoints.findAll);

    try {
      final http.Response response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body.data);
        List<Project> projects =
            jsonResponse.map((json) => Project.fromJson(json)).toList();
        return projects;
      }
    } catch (e) {
      // Handle any network errors
      print('Error: $e');
    }
  }

  Future<Project> createOneBookmark(int projectId, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.bookmarkEndpoints.createOne);
    Map<String, dynamic> body = {'projectId ': projectId};

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
        Map<String, dynamic> jsonResponse = json.decode(response.body.data);
        Project project = Project.fromJson(jsonResponse);
        return project;
      }
    } catch (e) {
      // Handle any network errors
      print('Error: $e');
    }
  }

  Future<bool> deleteOneBookmark(int projectId, String token) async {
    final Uri uri =
        Uri.parse(API.baseUrl + API.bookmarkEndpoints.deleteOne(projectId));

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
    } catch (e) {
      // Handle any network errors
      print('Error: $e');
    }
  }
}
