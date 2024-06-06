import 'package:flutter/material.dart';
import 'package:vocablury/components/bottom_sheet.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/start_lesson/listening_questions.dart';
import 'package:vocablury/home_module/view/start_lesson/meaning_questions.dart';
import 'package:vocablury/home_module/view/start_lesson/speak_questions.dart';
import 'package:vocablury/home_module/view/start_lesson/translate_questions.dart';
import 'package:vocablury/utilities/functions.dart';
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

  void checkTranslateSentence({
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

  void checkSpeakingSentence({
    required String mappedSentence,
    required String correctSentence,
    required VoidCallback correctAnswerButtonPressed,
    required VoidCallback wrongAnswerButtonPressed,
  }) {
    debugPrint("$mappedSentence    $correctSentence");

    if (correctSentence.toLowerCase() == mappedSentence.toLowerCase()) {
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

  void checkMeaningSentence({
    required String correctSentence,
    required String mappedSentence,
    required VoidCallback correctAnswerButtonPressed,
    required VoidCallback wrongAnswerButtonPressed,
  }) {
    debugPrint("$mappedSentence    $correctSentence");

    if (correctSentence.toLowerCase() == mappedSentence.toLowerCase()) {
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
      "question":
          "https://d2357je2x03wmv.cloudfront.net/f2pncn%2Ffile%2Fe78fff13fe5c58524aaff73ce537ef7f_c10e4530c72801d8f7a6c0996b536ab2.mp3?response-content-disposition=inline%3Bfilename%3D%22e78fff13fe5c58524aaff73ce537ef7f_c10e4530c72801d8f7a6c0996b536ab2.mp3%22%3B&response-content-type=audio%2Fmpeg&Expires=1717678732&Signature=MOzEAF2AKgfKdyK1zaH-V1NWEtnw5IeOtBERb9ZC6aGqI8sCyxLxA-EZFtjI7VVjmPCyBRcxmgF4J15azx8SqteXDiJHfldzudtb9Hx7hnCWVy7AWlEvW4nflW2hnlZK4WqlVglZ7qiC8nfxK~5AttHIsZ3s-5wYf4zk29K9uq~MW7UwggUIIm9GkilfQLZaVhB6jHHwFxmlsL2wU60HHlqF1KKnbDn8l9AreCmTKHrALEdBTFG-DDnTGFuijEKbwBzOn-3XNgK4NoUZvfo1bBlJfCxYRU8NlLJdpYa5bILHromW3QjMB~jRYjFridG4-4NVRHf-2vuaDL~VPUNWmg__&Key-Pair-Id=APKAJT5WQLLEOADKLHBQ",
      "correctSentence": "Hello and welcome to gradding",
      "type": "listening",
      "options": ["to", "Hello", "gradding", "and", "welcome"]
    },
    {
      "question": "The boy is eating a burger",
      "correctSentence": "eating a burger",
      "type": "meaning",
      "options": [
        "The boy is eating",
        "boy is eating",
        "eating a burger",
        "burger is eating by a boy by burger"
      ]
    },
    {
      "question": "The Call is from your mother",
      "correctSentence": "The Call is from your mother",
      "type": "speaking",
      "options": ["gracefully", "danced", "She", "on", "the", "stage"]
    },
    {
      "question": "The big red apple fell from the tree",
      "correctSentence": "The big red apple fell from the tree",
      "type": "translate",
      "options": ["fell", "red", "tree", "big", "the", "apple", "from", "The"]
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
                String ques = question['question'];
                String questionType = question['type'];
                String correctSentence = question['correctSentence'];
                List<String> options = List<String>.from(question['options']);
                return Column(
                  children: [
                    if (questionType == "translate")
                      TranslateQuestions(
                        questionHeading: getQuestionHeading(questionType),
                        question: ques,
                        jumbledWords: options,
                        answerMap: answerMap,
                        onChange: () => setState(() {}),
                      ),
                    if (questionType == "speaking")
                      SpeakingQuestions(
                        questionHeading: getQuestionHeading(questionType),
                        correctSentence: ques,
                        answerMap: answerMap,
                        onChange: () => setState(() {}),
                      ),
                    if (questionType == "meaning")
                      MeaningQuestions(
                        options: options,
                        questionHeading: getQuestionHeading(questionType),
                        correctSentence: ques,
                        answerMap: answerMap,
                        onChange: () => setState(() {}),
                      ),
                    if (questionType == "listening")
                      ListeningQuestions(
                        options: options,
                        questionHeading: getQuestionHeading(questionType),
                        questionUrl: ques,
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
                          backgroundColor: answerMap.containsKey(ques) && answerMap[ques].isNotEmpty
                              ? GlobalColors.primaryColor
                              : GlobalColors.borderColor,

                          foregroundColor: answerMap.containsKey(ques) && answerMap[ques].isNotEmpty
                              ? Colors.white
                              : AppColors.battleshipGrey,
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (answerMap.containsKey(ques) && answerMap[ques].isNotEmpty) {
                            if (questionType == "translate") {
                              checkTranslateSentence(
                                correctSentence: correctSentence,
                                selectedWords: answerMap[ques],
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

                            if (questionType == "speaking") {
                              checkSpeakingSentence(
                                correctSentence: correctSentence,
                                mappedSentence: answerMap[ques],
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
                            if (questionType == "meaning") {
                              checkMeaningSentence(
                                correctSentence: correctSentence,
                                mappedSentence: answerMap[ques],
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

                            if (questionType == "listening") {
                              checkTranslateSentence(
                                correctSentence: correctSentence,
                                selectedWords: answerMap[ques],
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
