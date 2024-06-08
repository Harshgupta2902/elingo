import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/start_lesson/flutter_tts.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/functions.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

typedef OnChangeCallBack = void Function();

class SpeakingQuestions extends StatefulWidget {
  const SpeakingQuestions({
    super.key,
    required this.correctSentence,
    required this.answerMap,
    required this.onChange,
    required this.questionHeading,
  });

  final String correctSentence;
  final Map<String, dynamic> answerMap;
  final OnChangeCallBack onChange;
  final String questionHeading;

  @override
  State<SpeakingQuestions> createState() => _SpeakingQuestionsState();
}

class _SpeakingQuestionsState extends State<SpeakingQuestions> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  final List<String> _recognizedWords = [];
  TextToSpeechService ttsService = TextToSpeechService();

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<bool> _requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  void _initSpeech() async {
    if (await _requestMicrophonePermission()) {
      bool available = await _speechToText.initialize(
        onStatus: (val) => debugPrint('onStatus: $val'),
        onError: (val) => debugPrint('onError: $val'),
      );
      setState(() {
        _speechEnabled = available;
      });
    } else {
      setState(() {
        _speechEnabled = false;
      });
    }
  }

  void _startListening() async {
    if (_speechEnabled) {
      _recognizedWords.clear();
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {});
    } else {
      debugPrint('Speech recognition not available.');
    }
  }

  void stopListening() {
    _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    debugPrint(result.recognizedWords.toString());
    setState(() {
      _recognizedWords.add(result.recognizedWords);
      widget.answerMap[widget.correctSentence] = _recognizedWords.last;
      debugPrint(widget.answerMap.toString());
      widget.onChange();
    });
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
          Row(
            children: [
              SvgPicture.asset(GlobalImages.smile),
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetPath.dialogLeft),
                      fit: BoxFit.fill,
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 26, right: 16, top: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => ttsService.speak(widget.correctSentence),
                        child:
                            const Icon(Icons.volume_up, color: GlobalColors.primaryColor, size: 24),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          widget.correctSentence,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: GlobalColors.borderColor, thickness: 1),
          ),
          GestureDetector(
            onTap: () {
              if (_speechToText.isNotListening) {
                _startListening();
                return;
              }
              if (_speechToText.isListening) {
                stopListening();
                return;
              }
            },
            child: Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 26),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(_speechToText.isNotListening ? 16 : 0),
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 16),
                  side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                ),
              ),
              child: _speechToText.isNotListening
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.mic, color: GlobalColors.primaryColor, size: 30),
                        const SizedBox(width: 8),
                        Text(
                          "Tap To talk",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600, color: GlobalColors.primaryColor),
                        )
                      ],
                    )
                  : Lottie.asset(AssetPath.wavesLottie, fit: BoxFit.fill, height: 80),
            ),
          ),
          Text(
            _recognizedWords.isNotEmpty ? capitalizeFirstWord(_recognizedWords.last) : '',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
