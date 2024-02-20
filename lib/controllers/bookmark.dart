import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';
// import 'package:zero_waste_application/models/project.dart';

class BookmarkController {
  Future<List<dynamic>?> getAllBookmarks(String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.bookmarkEndpoints.findAll);

    try {
      final http.Response response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print("RE");
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> projects = jsonResponse['projects ='];
        return projects;
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> createOneBookmark(
      int projectId, String token) async {
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
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        Map<String, dynamic> project = jsonResponse['data'];
        return project;
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
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
      return false;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
