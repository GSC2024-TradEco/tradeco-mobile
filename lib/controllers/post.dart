import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:zero_waste_application/utils/api_endpoints.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class PostController {
  Future<List<dynamic>?> getAllPosts(String token) async {
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

  Future<bool> createOnePost(
      String title, String description, File? image, String token) async {
    final Uri uri = Uri.parse(API.baseUrl + API.postEndpoints.createOne);

    try {
      final request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['title'] = title;
      request.fields['description'] = description;

      if (image != null) {
        final imageFile = File(image.path);

        final MimeType = lookupMimeType(imageFile.path);

        final imageField = await http.MultipartFile.fromPath(
            'file', imageFile.path,
            contentType: MediaType.parse(MimeType!));
        request.files.add(imageField);
      }

      var response = await request.send();

      var responseBody = await response.stream.bytesToString();
      final json = jsonDecode(responseBody);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
