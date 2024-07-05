// This file is dual-licensed under GPLv3 and Commercial License
// See the LICENSE file in the project root for license information.

import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  stt.SpeechToText _speech = stt.SpeechToText();

  Future<bool> initialize() async {
    return await _speech.initialize();
  }

  void listen(Function(String) onResult, Function(String) onError) {
    _speech.listen(
      onResult: (val) => onResult(val.recognizedWords),
    );
    _speech.errorListener = (val) => onError(val.errorMsg);
  }

  void setStatusListener(Function(String) onStatus) {
    _speech.statusListener = (status) => onStatus(status);
  }

  void stop() {
    _speech.stop();
  }
}
