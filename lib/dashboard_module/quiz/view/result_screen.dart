import 'package:flutter/material.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/dashboard_module/quiz/model/daily_quiz_model.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

class TestResultPage extends StatelessWidget {
  final List<Questions> questions;
  final List<int> selectedAnswers;
  final int correctCount;

  const TestResultPage({
    Key? key,
    required this.questions,
    required this.selectedAnswers,
    required this.correctCount,
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
      body:
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questions[index];
          final selectedAnswerIndex = selectedAnswers[index];
          final selectedAnswer = selectedAnswerIndex != -1
              ? question.options != null &&
                      selectedAnswerIndex < question.options!.length // Ensure index is within bounds
                  ? question.options![selectedAnswerIndex] // Retrieve the selected option
                  : ''
              : "";
          final correctAnswer = question.correctAnswer;
          final isCorrect = selectedAnswer == correctAnswer;

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
                  Text(
                    'Question ${index + 1}: ${question.question}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Your Answer: $selectedAnswer',
                    style: TextStyle(
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                  Text(
                    'Correct Answer: $correctAnswer',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  if (!isCorrect)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Wrong',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Image.asset(
                          AssetPath.wrong,
                          width: 20,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
