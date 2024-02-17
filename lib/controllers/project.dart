import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';
import 'package:zero_waste_application/models/project.dart';

class ProjectController {
  Future<List<Project>?> getAllProjects(String token) async {
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
        List<dynamic> jsonResponse = json.decode(response.body);
        List<Project> projects =
            jsonResponse.map((json) => Project.fromJson(json)).toList();
        return projects;
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Project?> getOneProject(int projectId, String token) async {
    final Uri uri =
        Uri.parse(API.baseUrl + API.projectEndpoints.findOne(projectId));

    try {
      final http.Response response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        Project project = Project.fromJson(jsonResponse['data']);
        return project;
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
