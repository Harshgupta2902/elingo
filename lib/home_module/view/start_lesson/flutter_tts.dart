import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  late FlutterTts flutterTts;

  TextToSpeechService() {
    flutterTts = FlutterTts();
    initTts();
  }

  Future<void> initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  void stop() async {
    await flutterTts.stop();
  }

  void dispose() {
    flutterTts.stop();
  }
}
