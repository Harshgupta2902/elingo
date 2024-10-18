import 'package:flutter/material.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/dashboard_module/quiz/model/quiz_model.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

class QuizResultView extends StatelessWidget {
  final List<Questions> questions;
  final Map<String, dynamic> userAnswers;

  const QuizResultView({
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
    );
  }
}
