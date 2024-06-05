import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

typedef OnChangeCallBack = void Function();

class TranslateQuestions extends StatefulWidget {
  const TranslateQuestions({
    super.key,
    required this.jumbledWords,
    required this.correctSentence,
    required this.answerMap,
    required this.onChange,
  });

  final List<String> jumbledWords;
  final String correctSentence;
  final Map<String, dynamic> answerMap;
  final OnChangeCallBack onChange;
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
            "Translate this Sentence",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: GlobalColors.borderColor, thickness: 1),
          ),
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: GlobalColors.primaryColor,
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.volume_up, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  widget.correctSentence,
                  style:
                      Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Wrap(
              runAlignment: WrapAlignment.center,
              runSpacing: 12,
              spacing: 16,
              children:
                  List.generate(widget.answerMap[widget.correctSentence]?.length ?? 0, (index) {
                final word = widget.answerMap[widget.correctSentence]?[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.answerMap[widget.correctSentence]?.removeAt(index);
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
                    widget.answerMap[widget.correctSentence] ??= [];
                    widget.answerMap[widget.correctSentence]?.add(word);

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
