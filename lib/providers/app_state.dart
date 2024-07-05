// This file is dual-licensed under GPLv3 and Commercial License
// See the LICENSE file in the project root for license information.

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sai/services/chat_gpt_service.dart';
import 'package:sai/services/speech_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppState extends ChangeNotifier {
  final SpeechService _speechService = SpeechService();
  FlutterTts _flutterTts = FlutterTts();
  late final ChatGPTService _chatGPTService;
  String _text = "Tap the microphone to start speaking";
  bool _isListening = false;
  String _chatResponse = "";

  AppState() {
    _chatGPTService = ChatGPTService(
        'YOUR_CHATGPT_API_KEY'); // Replace with your ChatGPT API key
    _speechService.setStatusListener((status) {
      if (status == 'done' || status == 'notListening') {
        _isListening = false;
        notifyListeners();
      }
    });
  }

  String get text => _text;
  bool get isListening => _isListening;
  String get chatResponse => _chatResponse;

  void listen() async {
    if (!_isListening) {
      bool available = await _speechService.initialize();
      if (available) {
        _isListening = true;
        notifyListeners();
        _speechService.listen(
          (result) {
            _text = result;
            notifyListeners();
          },
          (error) {
            _isListening = false;
            notifyListeners();
          },
        );
      }
    } else {
      _isListening = false;
      _speechService.stop();
      notifyListeners();
    }
  }

  Future<void> sendMessageToChatGPT(String message) async {
    final response = await _chatGPTService.sendMessage(message);
    if (response.isNotEmpty) {
      _chatResponse = response;
      _flutterTts.speak(_chatResponse);
      notifyListeners();
    }
  }

  Future<void> recognizeTextFromImage(String imagePath) async {
    // Replace with your Google Lens API key and endpoint
    final apiKey = 'YOUR_GOOGLE_LENS_API_KEY';
    final endpoint =
        'https://vision.googleapis.com/v1/images:annotate?key=$apiKey';

    final imageBytes = await http.MultipartFile.fromPath('image', imagePath);
    final request = http.MultipartRequest('POST', Uri.parse(endpoint))
      ..files.add(imageBytes);

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final decodedResponse = json.decode(responseBody);

    if (decodedResponse['responses'] != null &&
        decodedResponse['responses'].isNotEmpty &&
        decodedResponse['responses'][0]['fullTextAnnotation'] != null) {
      _text = decodedResponse['responses'][0]['fullTextAnnotation']['text'];
      _flutterTts.speak(_text);
      notifyListeners();
    }
  }
}
