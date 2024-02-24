import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';

class MessageController {
  Future<List<dynamic>?> getUserChats(String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.messageEndpoints.getUserChats);

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
      return null;
    }
  }

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
      return null;
    }
  }

  Future<Map<String, dynamic>?> createOneMessage(
      int userId, String text, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.messageEndpoints.createOne);
    Map<String, dynamic> body = {'receiverId': userId, 'text': text};

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
      return null;
    }
  }
}
