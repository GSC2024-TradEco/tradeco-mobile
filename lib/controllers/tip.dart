import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zero_waste_application/utils/api_endpoints.dart';
import 'package:zero_waste_application/models/tip.dart';

class TipController {
  Future<List<Tip>> getAllTips(String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.tipEndpoints.findAll);

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
        List<Tip> tips =
            jsonResponse.map((json) => Tip.fromJson(json)).toList();
        return tips;
      }
    } catch (e) {
      // Handle any network errors
      print('Error: $e');
    }
  }

  Future<Tip> getOneTip(int tipId, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.tipEndpoints.getOne(tipId));

    try {
      final http.Response response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = json.decode(response.body.data);
        Tip tip = Tip.fromJson(jsonResponse);
        return tip;
      }
    } catch (e) {
      // Handle any network errors
      print('Error: $e');
    }
  }
}
