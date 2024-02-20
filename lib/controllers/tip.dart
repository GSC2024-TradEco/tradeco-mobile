import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';
// import 'package:zero_waste_application/models/tip.dart';

class TipController {
  Future<List<dynamic>?> getAllTips() async {
    final Uri uri = Uri.parse(API.baseUrl + API.tipEndpoints.findAll);

    try {
      final http.Response response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
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

  Future<Map<String, dynamic>?> getOneTip(int tipId) async {
    final Uri uri = Uri.parse(API.baseUrl + API.tipEndpoints.findOne(tipId));

    try {
      final http.Response response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
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

  Future<Map<String, dynamic>?> getRandomTips() async {
    final Uri uri = Uri.parse(API.baseUrl + API.tipEndpoints.randomTips);

    try {
      final http.Response response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
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
