import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void playAudio({required String audio}) {
  AudioPlayer player = AudioPlayer();

  bool isURL(String str) {
    return Uri.tryParse(str)?.hasAbsolutePath ?? false;
  }

  bool isAsset(String str) {
    return str.startsWith('assets/');
  }

  Future<void> play() async {
    if (isURL(audio)) {
      debugPrint("url played $audio");
      await player.play(UrlSource(audio));
    } else if (isAsset(audio)) {
      debugPrint("asset played $audio");
      // await player.play(AssetSource(audio));
      await player.play(AssetSource(audio.replaceAll("assets/", "")));
    } else {
      debugPrint("local file path played $audio");
      await player.play(DeviceFileSource(audio));
    }
  }

  play();
}
