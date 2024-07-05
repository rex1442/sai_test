# SAI 프로젝트 설명서

## 개요

SAI 프로젝트는 Flutter로 개발된 장애인 및 노령자 버전의 스마트폰 애플리케이션입니다. 이 애플리케이션은 음성 인식, 텍스트 음성 변환, 이미지 텍스트 인식, ChatGPT를 활용한 대화 기능을 제공합니다.

## 기능 설명

### 음성 인식 (Speech Recognition)

사용자의 음성을 텍스트로 변환합니다. `speech_to_text` 패키지를 사용하여 구현되었습니다.

- **초기화:** `SpeechService.initialize()`
- **듣기 시작:** `SpeechService.listen(onResult, onError)`
- **듣기 중지:** `SpeechService.stop()`
- **상태 업데이트:** `SpeechService.setStatusListener(onStatus)`

### 텍스트 음성 변환 (Text-to-Speech)

텍스트를 음성으로 변환합니다. `flutter_tts` 패키지를 사용하여 구현되었습니다.

- **말하기:** `_flutterTts.speak(text)`

### 이미지 텍스트 인식 (Image Text Recognition)

이미지에서 텍스트를 인식합니다. Google Lens API를 사용하여 구현되었습니다.

- **이미지 텍스트 인식:** `AppState.recognizeTextFromImage(imagePath)`

### ChatGPT 대화 기능

OpenAI의 ChatGPT를 사용하여 사용자의 질문에 답변합니다. `chat_gpt_sdk` 패키지를 사용하여 구현되었습니다.

- **메시지 보내기:** `ChatGPTService.sendMessage(message)`

## 사용법

### 음성 인식 사용 예시

```dart
final speechService = SpeechService();
speechService.initialize();
speechService.listen(
  (result) {
    print('Recognized words: $result');
  },
  (error) {
    print('Error: $error');
  }
);
```

### 텍스트 음성 변환 사용 예시

final flutterTts = FlutterTts();
flutterTts.speak('Hello, this is a text-to-speech example.');

### 이미지 텍스트 인식 사용 예시

final appState = AppState();
appState.recognizeTextFromImage('path_to_your_image_file.jpg');

### ChatGPT 대화 기능 사용 예시

final chatService = ChatGPTService('YOUR_CHATGPT_API_KEY');
chatService.sendMessage('Hello, ChatGPT!').then((response) {
print('ChatGPT Response: $response');
});

### 의존성 설치

flutter pub get

### 애플리케이션 실행

flutter run

### 기여

기여를 원하시는 분은 이 저장소를 포크하고 풀 리퀘스트를 보내주시기 바랍니다.

### 라이선스

이 프로젝트는 듀얼 라이선스 하에 배포됩니다.

This project is licensed under a dual license scheme:

- **GPLv3 License**: You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. See the [LICENSE](./LICENSE) file for more details.

- **Commercial License**: For any commercial use, you must obtain a commercial license. Using this software in any commercial product or service without a proper commercial license is strictly prohibited and will result in legal actions. Please contact us at [rex1442@naver.com] or [rex1442@gmail.com] for pricing and terms.
