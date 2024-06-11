import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/components/lesson_functions.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

typedef OnChangeCallBack = void Function();

class TranslateQuestions extends StatefulWidget {
  const TranslateQuestions({
    super.key,
    required this.jumbledWords,
    required this.question,
    required this.answerMap,
    required this.onChange,
    required this.questionHeading,
  });

  final List<dynamic> jumbledWords;
  final String question;
  final Map<String, dynamic> answerMap;
  final OnChangeCallBack onChange;
  final String questionHeading;
  @override
  State<TranslateQuestions> createState() => _TranslateQuestionsState();
}

class _TranslateQuestionsState extends State<TranslateQuestions> {
  List<String> showWords = [];
  List<String> removedIndices = [];

  @override
  void initState() {
    super.initState();
    showWords = List.from(widget.jumbledWords);
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
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: GlobalColors.borderColor, thickness: 1),
          ),
          getSpeakerWidget(question: widget.question, context: context),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Wrap(
              runAlignment: WrapAlignment.center,
              runSpacing: 12,
              spacing: 16,
              children: List.generate(widget.answerMap[widget.question]?.length ?? 0, (index) {
                final word = widget.answerMap[widget.question]?[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.answerMap[widget.question]?.removeAt(index);
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
                    widget.answerMap[widget.question] ??= [];
                    widget.answerMap[widget.question]?.add(word);

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
