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
import 'package:vocablury/utilities/theme/app_colors.dart';

typedef OnChangeCallBack = void Function();

class ListeningQuestions extends StatefulWidget {
  const ListeningQuestions({
    super.key,
    required this.questionUrl,
    required this.answerMap,
    required this.onChange,
    required this.questionHeading,
    required this.options,
  });

  final String questionUrl;
  final Map<String, dynamic> answerMap;
  final OnChangeCallBack onChange;
  final String questionHeading;
  final List<String> options;

  @override
  State<ListeningQuestions> createState() => _ListeningQuestionsState();
}

class _ListeningQuestionsState extends State<ListeningQuestions> {
  AudioPlayer player = AudioPlayer();
  List<String> showWords = [];
  List<String> removedIndices = [];

  @override
  void initState() {
    super.initState();
    showWords = List.from(widget.options);
  }

  Future<void> _playAudio() async {
    await player.play(UrlSource(widget.questionUrl));
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _playAudio(),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: GlobalColors.primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: GlobalColors.primaryColor.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: GlobalColors.primaryColor,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Tap to play audio",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.battleshipGrey),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Wrap(
              runAlignment: WrapAlignment.center,
              runSpacing: 12,
              spacing: 16,
              children: List.generate(widget.answerMap[widget.questionUrl]?.length ?? 0, (index) {
                final word = widget.answerMap[widget.questionUrl]?[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.answerMap[widget.questionUrl]?.removeAt(index);
                      removedIndices.remove(word);
                      widget.onChange();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(cornerRadius: 24),
                        side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                      ),
                    ),
                    child: Text(
                      word,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            runAlignment: WrapAlignment.center,
            runSpacing: 12,
            spacing: 16,
            children: List.generate(showWords.length, (index) {
              final word = showWords[index];

              final isContains = removedIndices.contains(word);
              return GestureDetector(
                onTap: () {
                  if (isContains == true) {
                    return;
                  }

                  setState(() {
                    removedIndices.add(word);
                    widget.answerMap[widget.questionUrl] ??= [];
                    widget.answerMap[widget.questionUrl]?.add(word);

                    debugPrint("+++++ ${widget.answerMap}");
                    widget.onChange();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: ShapeDecoration(
                    color: isContains ? GlobalColors.borderColor : null,
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(cornerRadius: 24),
                      side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                    ),
                  ),
                  child: Text(
                    showWords[index],
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: isContains ? Colors.transparent : Colors.black),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
