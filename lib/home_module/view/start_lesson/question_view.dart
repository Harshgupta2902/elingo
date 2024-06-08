import 'package:flutter/material.dart';
import 'package:vocablury/components/bottom_sheet.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/start_lesson/lesson_functions.dart';
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

  static const questions = [
    {
      "question": "Matching Questions",
      "correctSentence": "completed",
      "type": "matching",
      "options": [
        ["Apple", "Dog", "Car"],
        ["A fruit", "An animal", "A vehicle"]
      ],
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
      "question":
          "https://d2357je2x03wmv.cloudfront.net/f2pncn%2Ffile%2Fe78fff13fe5c58524aaff73ce537ef7f_c10e4530c72801d8f7a6c0996b536ab2.mp3?response-content-disposition=inline%3Bfilename%3D%22e78fff13fe5c58524aaff73ce537ef7f_c10e4530c72801d8f7a6c0996b536ab2.mp3%22%3B&response-content-type=audio%2Fmpeg&Expires=1717678732&Signature=MOzEAF2AKgfKdyK1zaH-V1NWEtnw5IeOtBERb9ZC6aGqI8sCyxLxA-EZFtjI7VVjmPCyBRcxmgF4J15azx8SqteXDiJHfldzudtb9Hx7hnCWVy7AWlEvW4nflW2hnlZK4WqlVglZ7qiC8nfxK~5AttHIsZ3s-5wYf4zk29K9uq~MW7UwggUIIm9GkilfQLZaVhB6jHHwFxmlsL2wU60HHlqF1KKnbDn8l9AreCmTKHrALEdBTFG-DDnTGFuijEKbwBzOn-3XNgK4NoUZvfo1bBlJfCxYRU8NlLJdpYa5bILHromW3QjMB~jRYjFridG4-4NVRHf-2vuaDL~VPUNWmg__&Key-Pair-Id=APKAJT5WQLLEOADKLHBQ",
      "correctSentence": "Hello and welcome to gradding",
      "type": "listening",
      "options": ["to", "Hello", "gradding", "and", "welcome"]
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
    return WillPopScope(
      onWillPop: () async {
        exitAlert(
          context: context,
          onTap: () => MyNavigator.goNamed(GoPaths.dashboardLevels),
        );
        return false;
      },
      child: Scaffold(
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
                  List<dynamic> options = List<dynamic>.from(question['options']);
                  return Column(
                    children: [
                      getQuestionWidget(
                        questionType: questionType,
                        questionHeading: getQuestionHeading(questionType),
                        ques: ques,
                        options: options,
                        questionUrl: ques,
                        correctSentence: correctSentence,
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
                                answerMap.containsKey(ques) && answerMap[ques].isNotEmpty
                                    ? GlobalColors.primaryColor
                                    : GlobalColors.borderColor,

                            foregroundColor:
                                answerMap.containsKey(ques) && answerMap[ques].isNotEmpty
                                    ? Colors.white
                                    : AppColors.battleshipGrey,
                            elevation: 0,
                          ),
                          onPressed: () {
                            if (answerMap.containsKey(ques) && answerMap[ques].isNotEmpty) {
                              vibratePhone();
                              handleAnswer(
                                context: context,
                                questionType: questionType,
                                correctSentence: correctSentence,
                                answerMap: answerMap[ques],
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
      ),
    );
  }
}
