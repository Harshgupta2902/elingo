import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/dashboard_module/quiz/controller/daily_quiz_controller.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

import 'dashboard_module/quiz/model/daily_quiz_model.dart';

final _quizController = Get.put(GetDailyQuizController());

class OnboardingQuestions extends StatefulWidget {
  const OnboardingQuestions({super.key});

  @override
  State<OnboardingQuestions> createState() => _OnboardingQuestionsState();
}

class _OnboardingQuestionsState extends State<OnboardingQuestions> {
  @override
  void initState() {
    super.initState();
    _quizController.getQuizQuestions(
      apiUrl: "https://run.mocky.io/v3/9f42f0bb-cde5-45bd-95c3-94a6c1cbb0fd",
    );
  }

  final PageController _pageController = PageController(initialPage: 0);

  Map<String, String> selectedAnswers = {};
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: const CustomAppBar(
        title: "Mock Test",
        isProfileView: false,
        bgColor: AppColors.zircon,
      ),
      body: _quizController.obx((state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: PageView(
            onPageChanged: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(_quizController.state?.questions?.length ?? 0, (index) {
              final question = state?.questions?[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Question ${currentPageIndex + 1}/${_quizController.state?.questions?.length ?? 0}",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.scienceBlue,
                          ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      question?.question ?? "",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkJungleGreen,
                          ),
                    ),
                    const SizedBox(height: 26),
                    ...List.generate(question?.options?.length ?? 0, (index) {
                      final option = question?.options?[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAnswers[question?.question ?? ""] = option ?? "";
                          });
                          debugPrint(selectedAnswers.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 28),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          decoration: AppBoxDecoration.getBorderBoxDecoration(
                            borderRadius: 10,
                            borderColor: selectedAnswers[question?.question ?? ""] == option
                                ? AppColors.scienceBlue
                                : Colors.white,
                            color: selectedAnswers[question?.question ?? ""] == option
                                ? AppColors.white.withOpacity(0.6)
                                : AppColors.white,
                          ),
                          child: Center(
                            child: Text(
                              option ?? "",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.balticSea,
                                  ),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              );
            }),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(28),
        decoration: AppBoxDecoration.getBoxDecoration(
          color: AppColors.zircon,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width, 60),
            backgroundColor: AppColors.scienceBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            // Check if the answer is selected for the current question
            if (selectedAnswers.containsKey(_quizController.state?.questions?[currentPageIndex].question)) {
              if (currentPageIndex < (_quizController.state?.questions?.length)! - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.ease,
                );
              } else {
                debugPrint("navigation is here $selectedAnswers");

                // return ;

                context.push(GoPaths.test, extra: {
                  "userAnswers": selectedAnswers,
                  "questions": _quizController.state?.questions,
                });
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(child: Text('Please select an answer before proceeding.')),
                ),
              );
            }
          },
          child: const Text("Save & Next"),
        ),
      ),
    );
  }
}

class QuizResultPage extends StatelessWidget {
  final List<Questions> questions;
  final Map<String, dynamic> userAnswers;

  const QuizResultPage({
    Key? key,
    required this.questions,
    required this.userAnswers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "Test Result",
        isProfileView: false,
        leadingPopAll: true,
        bgColor: AppColors.zircon,
        actionOnTap: () {
          return;
        },
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questions[index];
          final userAnswer = userAnswers[question.question]; // Use the question as the key
          final bool isCorrect = userAnswer == question.correctAnswer;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: AppBoxDecoration.getBorderBoxDecoration(
              showShadow: true,
              shadowColor: AppColors.zircon,
              color: AppColors.white,
              borderRadius: 16,
              blurRadius: 1,
              borderColor: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question.question ?? '', style: Theme.of(context).textTheme.titleSmall?.copyWith()),
                  const SizedBox(height: 8.0),
                  RichText(
                    text: TextSpan(
                      text: 'Your Answer: ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      children: [
                        TextSpan(
                          text: '${userAnswer ?? 'Not answered'}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: isCorrect ? Colors.green : Colors.red,
                              ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Correct Answer: ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      children: [
                        TextSpan(
                          text: '${question.correctAnswer}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (!isCorrect) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Wrong',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.red,
                              ),
                        ),
                        const SizedBox(width: 8.0),
                        Image.asset(
                          AssetPath.wrong,
                          height: 20,
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),

      // ListView.builder(
      //   itemCount: questions.length,
      //   itemBuilder: (context, index) {
      //     final question = questions[index];
      //     final userAnswer = userAnswers[question.question]; // Use the question as the key
      //     final bool isCorrect = userAnswer == question.correctAnswer;
      //
      //     return ListTile(
      //       title: Text(question.question ?? ''),
      //       subtitle: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text('Your Answer: ${userAnswer ?? 'Not answered'}'),
      //           Text('Correct Answer: ${question.correctAnswer}'),
      //           Text('Result: ${isCorrect ? 'Correct' : 'Incorrect'}'),
      //         ],
      //       ),
      //       trailing: Icon(
      //         isCorrect ? Icons.check_circle : Icons.cancel,
      //         color: isCorrect ? Colors.green : Colors.red,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
