// This file is dual-licensed under GPLv3 and Commercial License
// See the LICENSE file in the project root for license information.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sai/providers/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessible App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              appState.text,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: appState.listen,
              tooltip: 'Listen',
              child: Icon(appState.isListening ? Icons.mic : Icons.mic_none),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await appState.sendMessageToChatGPT(appState.text);
              },
              child: const Text("Send to ChatGPT"),
            ),
            const SizedBox(height: 20),
            Text(
              appState.chatResponse,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // 이미지 파일 경로를 설정하고 호출하세요.
                await appState
                    .recognizeTextFromImage('path_to_your_image_file.jpg');
              },
              child: const Text("Recognize Text from Image"),
            ),
          ],
        ),
      ),
    );
  }
}
