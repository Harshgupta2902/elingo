import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/functions.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

typedef OnChangeCallBack = void Function();

class ListeningQuestions extends StatefulWidget {
  const ListeningQuestions({
    super.key,
    required this.correctSentence,
    required this.answerMap,
    required this.onChange,
    required this.questionHeading,
    required this.options,
  });

  final String correctSentence;
  final Map<String, dynamic> answerMap;
  final OnChangeCallBack onChange;
  final String questionHeading;
  final List<String> options;

  @override
  State<ListeningQuestions> createState() => _ListeningQuestionsState();
}

class _ListeningQuestionsState extends State<ListeningQuestions> {
  AudioPlayer player = AudioPlayer();

  Future<void> playAudioFromUrl() async {
    String url =
        "https://d2357je2x03wmv.cloudfront.net/f2pncn%2Ffile%2Fe78fff13fe5c58524aaff73ce537ef7f_c10e4530c72801d8f7a6c0996b536ab2.mp3?response-content-disposition=inline%3Bfilename%3D%22e78fff13fe5c58524aaff73ce537ef7f_c10e4530c72801d8f7a6c0996b536ab2.mp3%22%3B&response-content-type=audio%2Fmpeg&Expires=1717678732&Signature=MOzEAF2AKgfKdyK1zaH-V1NWEtnw5IeOtBERb9ZC6aGqI8sCyxLxA-EZFtjI7VVjmPCyBRcxmgF4J15azx8SqteXDiJHfldzudtb9Hx7hnCWVy7AWlEvW4nflW2hnlZK4WqlVglZ7qiC8nfxK~5AttHIsZ3s-5wYf4zk29K9uq~MW7UwggUIIm9GkilfQLZaVhB6jHHwFxmlsL2wU60HHlqF1KKnbDn8l9AreCmTKHrALEdBTFG-DDnTGFuijEKbwBzOn-3XNgK4NoUZvfo1bBlJfCxYRU8NlLJdpYa5bILHromW3QjMB~jRYjFridG4-4NVRHf-2vuaDL~VPUNWmg__&Key-Pair-Id=APKAJT5WQLLEOADKLHBQ";
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.questionHeading,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: GlobalColors.borderColor, thickness: 1),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(cornerRadius: 16),
                side: const BorderSide(color: GlobalColors.borderColor, width: 2),
              ),
            ),
          )
        ],
      ),
    );
  }
}
