import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

typedef OnChangeCallBack = void Function();

class MatchingQuestions extends StatefulWidget {
  const MatchingQuestions({
    super.key,
    required this.answerMap,
    required this.onChange,
    required this.questionHeading,
    required this.options,
    required this.question,
  });

  final Map<String, dynamic> answerMap;
  final OnChangeCallBack onChange;
  final String questionHeading;
  final String question;
  final List<dynamic> options;

  @override
  State<MatchingQuestions> createState() => _MatchingQuestionsState();
}

class _MatchingQuestionsState extends State<MatchingQuestions> {
  Map<String, String> selectedPairs = {};
  String selectedWord = '';
  String selectedMeaning = '';
  int correctCount = 0;
  int incorrectCount = 0;

  void handleWordTap(String word) {
    setState(() {
      selectedWord = word;
      _checkPair();
    });
  }

  void handleMeaningTap(String meaning) {
    setState(() {
      selectedMeaning = meaning;
      _checkPair();
    });
  }

  void _checkPair() {
    if (selectedWord.isNotEmpty && selectedMeaning.isNotEmpty) {
      setState(() {
        selectedPairs[selectedWord] = selectedMeaning;
        if (isCorrectPair(selectedWord, selectedMeaning)) {
          correctCount++;
        } else {
          incorrectCount++;
        }
        selectedWord = '';
        selectedMeaning = '';

        bool allPairsMatched = true;
        for (var word in widget.options[0]) {
          if (!selectedPairs.containsKey(word)) {
            allPairsMatched = false;
            break;
          }
        }

        if (allPairsMatched) {
          widget.answerMap[widget.question] = 'completed';
          widget.onChange();
          debugPrint(widget.answerMap.toString());
        }
      });
    }
  }

  bool isCorrectPair(String word, String meaning) {
    var words = widget.options[0];
    var meanings = widget.options[1];
    int wordIndex = words.indexOf(word);
    int meaningIndex = meanings.indexOf(meaning);
    return wordIndex == meaningIndex;
  }

  @override
  Widget build(BuildContext context) {
    var words = widget.options[0];
    var meanings = widget.options[1];
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: words.map<Widget>((word) {
                    bool isSelected = selectedWord == word;
                    bool isPaired = selectedPairs.containsKey(word);
                    return GestureDetector(
                      onTap: () {
                        if (selectedPairs.containsKey(word)) {
                          return;
                        }
                        handleWordTap(word);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: ShapeDecoration(
                          color: isSelected
                              ? GlobalColors.primaryColor
                              : isPaired
                                  ? GlobalColors.borderColor
                                  : Colors.transparent,
                          shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(cornerRadius: 24),
                            side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                          ),
                        ),
                        child: Text(
                          word,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: isSelected
                                    ? Colors.white
                                    : isPaired
                                        ? Colors.transparent
                                        : null,
                              ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: meanings.map<Widget>((meaning) {
                    bool isSelected = selectedMeaning == meaning;
                    bool isPaired = selectedPairs.containsValue(meaning);
                    return GestureDetector(
                      onTap: () {
                        if (selectedPairs.containsValue(meaning)) {
                          return;
                        }
                        handleMeaningTap(meaning);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        decoration: ShapeDecoration(
                          color: isSelected
                              ? GlobalColors.primaryColor
                              : isPaired
                                  ? GlobalColors.borderColor
                                  : Colors.transparent,
                          shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(cornerRadius: 24),
                            side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                          ),
                        ),
                        child: Text(
                          meaning,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: isSelected
                                    ? Colors.white
                                    : isPaired
                                        ? Colors.transparent
                                        : null,
                              ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Correct pairs: $correctCount\nIncorrect pairs: $incorrectCount',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          GestureDetector(
              onTap: () {
                selectedPairs.clear();
              },
              child: Text("clear"))
        ],
      ),
    );
  }
}
