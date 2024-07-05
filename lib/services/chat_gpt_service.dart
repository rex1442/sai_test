// This file is dual-licensed under GPLv3 and Commercial License
// See the LICENSE file in the project root for license information.

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class ChatGPTService {
  late final OpenAI _openAI;

  ChatGPTService(String apiKey) {
    _openAI = OpenAI.instance.build(
      token: apiKey,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 20)),
    );
  }

  Future<String> sendMessage(String message) async {
    final request = ChatCompleteText(
      messages: [
        {
          "role": "user",
          "content": message,
        },
      ],
      maxToken: 50, // Corrected parameter name
      model: Gpt4ChatModel(), // Use the appropriate model constant
    );
    final response = await _openAI.onChatCompletion(request: request);
    if (response != null && response.choices.isNotEmpty) {
      final messageContent = response.choices.first.message?.content.trim();
      if (messageContent != null) {
        return messageContent;
      }
    }
    return "";
  }
}
