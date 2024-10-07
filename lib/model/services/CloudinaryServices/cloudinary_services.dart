import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';  // Add this line

class CloudinaryService {

  final String _cloudName = "dz0mfu819";  // Replace with your Cloudinary cloud name
  final String _apiKey = "411527767839221";        // Replace with your Cloudinary API key
  final String _apiSecret = "-q8FCH0vZklOo-tUre3zE6ilJFc";  // Replace with your Cloudinary API secret

  Future<String?> uploadFile(File file) async {
    try {
      String uploadUrl = "https://api.cloudinary.com/v1_1/$_cloudName/upload";

      // Determine file mime type
      String? mimeType = lookupMimeType(file.path);
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

      // Add file and required params
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,  // Use MIME type
      ));
      request.fields['upload_preset'] = 'tabibinet';  // Replace with your upload preset if needed
      request.fields['api_key'] = _apiKey;

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var data = json.decode(responseData.body);
        return data['secure_url']; // Get the URL of the uploaded file
      } else {
        throw Exception("Failed to upload file");
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
