import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';
import 'package:zero_waste_application/models/waste.dart';
import 'package:zero_waste_application/models/project.dart';

class WasteController {
  Future<List<Waste>> getAllWastes(String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.wasteEndpoints.findAll);

    try {
      final http.Response response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Waste> wastes =
            jsonList.map((json) => Waste.fromJson(json)).toList();
        return wastes;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Waste> createOneWaste(String waste, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.wasteEndpoints.createOne);
    Map<String, dynamic> body = {'waste ': waste};

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
        Waste waste = Waste.fromJson(jsonResponse);
        return waste;
      }
    } catch (e) {
      // Handle any network errors
      print('Error: $e');
    }
  }

  Future<bool> deleteOneWaste(int wasteId, String token) async {
    final Uri uri =
        Uri.parse(API.baseUrl + API.wasteEndpoints.deleteOne(wasteId));

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

  Future<List<Project>> getProjectSuggestions(
      List<String> wastes, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.wasteEndpoints.getSuggestion);
    final Map<String, List<String>> body = {
      'wastes': wastes,
    };

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
        List<Project> projects =
            jsonList.map((json) => Project.fromJson(json)).toList();
        return projects;
      }
    } catch (e) {
      // Handle any network errors
      print('Error: $e');
    }
  }
}
