import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/start_lesson/flutter_tts.dart';
import 'package:vocablury/home_module/view/start_lesson/lesson_functions.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

typedef OnChangeCallBack = void Function();

class MeaningQuestions extends StatefulWidget {
  const MeaningQuestions({
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
  State<MeaningQuestions> createState() => _MeaningQuestionsState();
}

class _MeaningQuestionsState extends State<MeaningQuestions> {

  int selectedOption = -1;
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
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: GlobalColors.borderColor, thickness: 1),
          ),
          getSpeakerWidget(question: widget.correctSentence, context: context),
          const SizedBox(height: 30),
          ...List.generate(widget.options.length, (index) {
            final options = widget.options[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = index;
                  widget.answerMap[widget.correctSentence] = options;
                  debugPrint(widget.answerMap.toString());
                  widget.onChange();
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: selectedOption == index
                      ? GlobalColors.secondaryButtonColor
                      : Colors.transparent,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(cornerRadius: 16),
                    side: BorderSide(
                        color: selectedOption == index
                            ? GlobalColors.primaryColor
                            : GlobalColors.borderColor,
                        width: 2),
                  ),
                ),
                child: Text(
                  options,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
