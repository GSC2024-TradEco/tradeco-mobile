import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';
// import 'package:zero_waste_application/models/project.dart';

class ProjectController {
  Future<List<dynamic>?> getAllProjects(String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.projectEndpoints.findAll);

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

  Future<Map<String, dynamic>?> getOneProject(
      int projectId, String token) async {
    final Uri uri =
        Uri.parse(API.baseUrl + API.projectEndpoints.findOne(projectId));
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
        Map<String, dynamic> data = jsonResponse['data'];
        return data;
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
