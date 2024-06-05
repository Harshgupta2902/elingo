import 'package:flutter/material.dart';
import 'package:vocablury/components/bottom_sheet.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/start_lesson/translate_questions.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  int currentPage = 1;
  Map<String, dynamic> answerMap = {};
  final PageController pageController = PageController();

  void checkSentence({
    required List selectedWords,
    required String correctSentence,
    required VoidCallback correctAnswerButtonPressed,
    required VoidCallback wrongAnswerButtonPressed,
  }) {
    debugPrint("$selectedWords    $correctSentence");

    String selectedSentence = selectedWords.join(' ');
    if (selectedSentence == correctSentence) {
      correctAnswerBottomSheet(
        correctAnswerButtonPressed: correctAnswerButtonPressed,
        context: context,
      );
    } else {
      wrongAnswerBottomSheet(
        wrongAnswerButtonPressed: wrongAnswerButtonPressed,
        correctAnswer: correctSentence,
        context: context,
      );
    }
  }

  static const questions = [
    {
      "sentence": "The big red apple fell from the tree",
      "jumbled_words": ["fell", "red", "tree", "big", "the", "apple", "from", "The"]
    },
    {
      "sentence": "She danced gracefully on the stage",
      "jumbled_words": ["gracefully", "danced", "She", "on", "the", "stage"]
    },
    {
      "sentence": "The old library contained many rare books",
      "jumbled_words": ["contained", "library", "books", "many", "rare", "old", "The"]
    },
    {
      "sentence": "He quietly opened the door and entered the room",
      "jumbled_words": ["entered", "room", "door", "opened", "the", "quietly", "and", "He"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VocabularyAppBar(
        leadingWidget: IconButton(
          splashRadius: 1,
          splashColor: Colors.transparent,
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              exitAlert(
                context: context,
                onTap: () {
                  MyNavigator.goNamed(GoPaths.dashboardLevels);
                },
              );
            }
          },
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        actionWidget: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("🔷", style: TextStyle(fontSize: 22)),
              const SizedBox(width: 6),
              Text(
                "957",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
        titleWidget: LinearProgressIndicator(
          minHeight: 12,
          color: GlobalColors.primaryColor,
          backgroundColor: GlobalColors.borderColor,
          borderRadius: SmoothBorderRadius(cornerRadius: 24),
          value: (currentPage / questions.length),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: PageView.builder(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                Map<String, dynamic> question = questions[index];
                String sentence = question['sentence'];
                List<String> jumbledWords = List<String>.from(question['jumbled_words']);
                return Column(
                  children: [
                    TranslateQuestions(
                      correctSentence: sentence,
                      jumbledWords: jumbledWords,
                      answerMap: answerMap,
                      onChange: () => setState(() {}),
                    ),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: GlobalColors.borderColor,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // splashFactory: NoSplash.splashFactory,
                          backgroundColor:
                              answerMap.containsKey(sentence) && answerMap[sentence].isNotEmpty
                                  ? GlobalColors.primaryColor
                                  : GlobalColors.borderColor,

                          foregroundColor:
                              answerMap.containsKey(sentence) && answerMap[sentence].isNotEmpty
                                  ? Colors.white
                                  : AppColors.battleshipGrey,
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (answerMap.containsKey(sentence) && answerMap[sentence].isNotEmpty) {
                            checkSentence(
                              correctSentence: sentence,
                              selectedWords: answerMap[sentence],
                              correctAnswerButtonPressed: () {
                                MyNavigator.pop();
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.bounceInOut,
                                );
                              },
                              wrongAnswerButtonPressed: () {
                                MyNavigator.pop();
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.bounceInOut,
                                );
                              },
                            );
                          }
                        },
                        child: const Text("Check Answers"),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
