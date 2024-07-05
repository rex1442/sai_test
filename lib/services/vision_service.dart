// This file is dual-licensed under GPLv3 and Commercial License
// See the LICENSE file in the project root for license information.

import 'dart:convert';
import 'package:http/http.dart' as http;

class VisionService {
  final String apiKey;
  final String endpoint;

  VisionService({required this.apiKey})
      : endpoint =
            'https://vision.googleapis.com/v1/images:annotate?key=$apiKey';

  Future<String> recognizeTextFromImage(String imagePath) async {
    final imageBytes = await http.MultipartFile.fromPath('image', imagePath);
    final request = http.MultipartRequest('POST', Uri.parse(endpoint))
      ..files.add(imageBytes);

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final decodedResponse = json.decode(responseBody);

    if (decodedResponse['responses'] != null &&
        decodedResponse['responses'].isNotEmpty &&
        decodedResponse['responses'][0]['fullTextAnnotation'] != null) {
      return decodedResponse['responses'][0]['fullTextAnnotation']['text'];
    }
    return "";
  }
}
