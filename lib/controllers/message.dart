import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';

class messageController {
  Future<List<dynamic>?> getAllMessages(int userId, String token) async {
    final Uri uri =
        Uri.parse(API.baseUrl + API.messageEndpoints.findAll(userId));

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

  Future<Map<String, dynamic>?> createOneWaste(
      String waste, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.messageEndpoints.createOne);
    Map<String, dynamic> body = {'waste': waste};

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