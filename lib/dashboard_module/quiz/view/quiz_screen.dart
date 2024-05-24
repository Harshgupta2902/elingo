import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/dashboard_module/quiz/controller/get_quiz_controller.dart';
import 'package:vocablury/dashboard_module/quiz/model/get_quiz_questions_model.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/my_navigator.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _quizController = Get.put(GetQuizQuestionsController());

  Timer? _timer;
  int _elapsedSeconds = 0;
  static const int timeLimitInSeconds = 50;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _quizController.getQuizQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        setState(() {
          _elapsedSeconds++;
        });
      },
    );
  }

  double _calculateProgress() {
    return _elapsedSeconds / timeLimitInSeconds;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  Widget _buildRemainingTime() {
    if (_timer != null) {
      final remainingTime = Duration(seconds: timeLimitInSeconds - _elapsedSeconds);
      final remainingTimeString = _formatDuration(remainingTime);
      final bool shouldBlink = remainingTime.inSeconds < 60;

      if (remainingTime.inSeconds <= 0) {
        submitAnswers(
          _quizController.state?.questions ?? [],
          _quizController.selectedAnswers,
          true,
        );

        _timer?.cancel();
        return Container();
      }

      return Text(
        remainingTimeString,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: shouldBlink ? AppColors.cadmiumRed : Colors.black,
            ),
      );
    }
    return Container(); // Return an empty container if the timer is null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Quiz",
        isProfileView: false,
        bgColor: AppColors.zircon,
        action: _buildRemainingTime(),
        actionOnTap: () {
          return;
        },
      ),
      backgroundColor: AppColors.zircon,
      body: _quizController.obx((state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: LinearProgressIndicator(
                  value: _calculateProgress(),
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.scienceBlue,
                  ),
                  semanticsValue: '${_calculateProgress() * 100}%',
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ListView.builder(
                itemCount: state?.questions?.length ?? 0,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ${state?.questions?[index].question}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            state?.questions?[index].options?.length ?? 0,
                            (optionIndex) {
                              final key = state?.questions?[index];
                              final optionText = key?.options?[optionIndex] ?? '';

                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                title: Obx(() {
                                  final isSelected = _quizController.selectedAnswers[index] == optionIndex;

                                  return Container(
                                    height: 40,
                                    decoration: AppBoxDecoration.getBorderBoxDecoration(
                                      borderRadius: 12,
                                      color: AppColors.zircon,
                                      borderColor: isSelected
                                          ? AppColors.scienceBlue
                                          : Colors.grey.withOpacity(
                                              0.5,
                                            ),
                                      showShadow: true,
                                      borderWidth: isSelected ? 2.0 : 1.0,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            optionText.toString(),
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                  color: isSelected ? AppColors.scienceBlue : Colors.black,
                                                ),
                                          ),
                                          isSelected
                                              ? const Icon(
                                                  Icons.check_circle,
                                                  color: AppColors.scienceBlue,
                                                )
                                              : const Icon(
                                                  Icons.circle_outlined,
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                                onTap: () {
                                  _quizController.selectedAnswers[index] = optionIndex;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      }),
      floatingActionButton: _quizController.obx(
        (state) {
          return FloatingActionButton(
            onPressed: () {
              submitAnswers(
                state?.questions ?? [],
                _quizController.selectedAnswers,
                false,
              );
            },
            child: const Icon(Icons.check),
          );
        },
        onLoading: const Text(""),
      ),
    );
  }

  submitAnswers(List<Questions> questionsData, List<int> selectedAnswers, bool? isTimeOut) {
    int correctCount = 0;
    bool allQuestionsAnswered = true;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] != -1) {
        String selectedAnswer = questionsData[i].options?[selectedAnswers[i]] ?? '';
        String correctAnswer = questionsData[i].correctAnswer ?? '';
        if (selectedAnswer == correctAnswer) {
          correctCount++;
        }
      } else {
        allQuestionsAnswered = false;
        debugPrint("loop is terminated because all questions are not answered");
        break;
      }
    }

    if (allQuestionsAnswered && isTimeOut == false) {
      MyNavigator.pushNamed(GoPaths.resultPage, extra: {
        "questions": questionsData,
        "selectedAnswers": selectedAnswers,
        "correctCount": correctCount,
        "totalTimeInSeconds": _elapsedSeconds,
      });
      _timer?.cancel();
    } else {
      if (isTimeOut == true) {
        MyNavigator.pushNamed(GoPaths.resultPage, extra: {
          "questions": questionsData,
          "selectedAnswers": selectedAnswers,
          "correctCount": correctCount,
          "totalTimeInSeconds": _elapsedSeconds,
        });
        debugPrint("isTimeOut == true. ----------------------- ");
        return;
      }
      debugPrint("Please attempt all questions before submitting.");
    }
  }
}

class ResultPage extends StatelessWidget {
  final List<Questions> questions;
  final List<int> selectedAnswers;
  final int correctCount;
  final int totalTimeInSeconds;

  const ResultPage({
    Key? key,
    required this.questions,
    required this.selectedAnswers,
    required this.correctCount,
    required this.totalTimeInSeconds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration totalTime = Duration(seconds: totalTimeInSeconds);
    String formattedTotalTime = _formatDuration(totalTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        leading: GestureDetector(
          onTap: () {
            context.go(GoPaths.dashBoard);
          },
          child: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: questions.isEmpty
          ? const Text("No questions found")
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Score: $correctCount/${questions.length}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Total Time: $formattedTotalTime',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      bool isCorrect =
                          questions[index].options?[selectedAnswers[index]] == questions[index].correctAnswer;
                      Color textColor = isCorrect ? Colors.green : Colors.red;

                      return ListTile(
                        title: Text(
                          'Question ${index + 1}: ${questions[index].question}',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Correct Answer: ${questions[index].correctAnswer}',
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                            Text(
                              'Your Answer: ${questions[index].options?[selectedAnswers[index]]}',
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
