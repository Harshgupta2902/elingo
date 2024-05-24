import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/dashboard_module/quiz/controller/daily_quiz_controller.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/my_navigator.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

final _quizController = Get.put(GetDailyQuizController());

typedef OnTestCompleted = Function(int);

class DailyQuizScreen extends StatefulWidget {
  final String apiUrl;
  final int? completedIndex;
  final OnTestCompleted onTestCompleted;

  const DailyQuizScreen({
    Key? key,
    required this.apiUrl,
    this.completedIndex,
    required this.onTestCompleted,
  }) : super(key: key);

  @override
  State<DailyQuizScreen> createState() => DailyQuizScreenState();
}

class DailyQuizScreenState extends State<DailyQuizScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  final selectedOption = "".obs;
  final currentQuestionIndex = 0.obs;
  final answered = false.obs;
  final secondsLeft = 5.obs;
  Timer? timer;
  Map<String, String> answerStatus = {};

  @override
  void initState() {
    super.initState();
    _quizController.getQuizQuestions(apiUrl: widget.apiUrl).then((value) {
      startTimer();
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: secondsLeft.value),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  startTimer() async {
    while (true) {
      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );

      if (secondsLeft.value > 0) {
        secondsLeft.value--;
      }

      if (secondsLeft.value <= 0) {
        debugPrint("timer End here");

        _updateAnswerStatus(
          _quizController.state?.questions?[currentQuestionIndex.value].question ?? "",
          "Not Attempted",
        );

        currentQuestionIndex.value++;
        selectedOption.value = '';
        answered.value = false;
        debugPrint("here is the restart after   updated index ${currentQuestionIndex.value}");

        _restartTimer();
        debugPrint("answer status: $answerStatus");
      }

      if (currentQuestionIndex.value + 2 == (_quizController.state?.questions?.length ?? 0) + 1 &&
          answered.value == false &&
          secondsLeft.value <= 1) {
        _updateAnswerStatus(
          _quizController.state?.questions?[currentQuestionIndex.value].question ?? "",
          "Not Attempted",
        );
        debugPrint("function called  secondsLeft :  ${secondsLeft.value}");
        debugPrint("function called  End here");

        _quizController.testSubmitted.value = true;

          MyNavigator.pushNamed(
            GoPaths.quizResultView,
            extra: {
              "userAnswers": answerStatus,
              "questions": _quizController.state?.questions,
            },
          );


        widget.onTestCompleted((widget.completedIndex)! + 1 ?? 0);
        return; // Return from the function after submitting the test
      }
    }
  }

  _restartTimer() {
    _controller.reset();
    secondsLeft.value = 5;
    _controller.forward();
    debugPrint("timer restarted here ");
  }

  void _updateAnswerStatus(String questionKey, String option) {
    setState(() {
      answerStatus[questionKey] = option;
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    _quizController.timer?.cancel();
    timer?.cancel();
    super.dispose();
  }

  checkAnswer(String option) {
    selectedOption.value = option;
    answered.value = true;
  }

  Widget assetIcon(String name) {
    if (name == '') {
      return Container();
    } else {
      return Image.asset(name, width: 20);
    }
  }

  //  ---------------  add data in hive dataBase ------------------

  void nextQuestion(
    int index,
    String option,
  ) async {
    if (selectedOption.value.isEmpty) {
      return;
    }

    selectedOption.value = option;
    answered.value = true;

    final lastIndex = _quizController.state?.questions?.length ?? 0;

    if (index >= lastIndex - 1) {
      _updateAnswerStatus(_quizController.state?.questions?[currentQuestionIndex.value].question ?? "", option);

      timer?.cancel();
      _quizController.testSubmitted.value = true;

      MyNavigator.pushNamed(GoPaths.quizResultView, extra: {
        "userAnswers": answerStatus,
        "questions": _quizController.state?.questions,
      });

      debugPrint("end Quiz ");
      return;
    }

    if (index < lastIndex - 1) {
      _updateAnswerStatus(_quizController.state?.questions?[currentQuestionIndex.value].question ?? "", option);
      currentQuestionIndex.value++;
      selectedOption.value = '';
      answered.value = false;

      _restartTimer();
      debugPrint("here is the next tap updated map $answerStatus");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: const CustomAppBar(
        title: "",
        isProfileView: false,
        leadingIconColor: AppColors.white,
        bgColor: AppColors.scienceBlue,
      ),
      body: _quizController.obx(
        (state) {
          return Column(
            children: [
              Stack(
                children: [
                  Obx(
                    () {
                      return Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 4.8,
                            decoration: const BoxDecoration(
                              color: AppColors.scienceBlue,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  20,
                                ),
                                bottomRight: Radius.circular(
                                  20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 80,
                            child: Container(
                              decoration: AppBoxDecoration.getBorderBoxDecoration(
                                color: Colors.white,
                                showShadow: true,
                                borderRadius: 12,
                                shadowColor: Colors.grey.withOpacity(
                                  0.5,
                                ),
                                borderColor: AppColors.white,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 25,
                              ),
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Question ${currentQuestionIndex.value + 1}/${_quizController.state?.questions?.length ?? 0}",
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: AppColors.scienceBlue,
                                        ),
                                  ),
                                  Text(
                                    _quizController.state?.questions?[currentQuestionIndex.value].question ?? '',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: AppColors.black.withOpacity(
                                            0.6,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: -35,
                            child: Container(
                              clipBehavior: Clip.none,
                              height: MediaQuery.of(context).size.height * 25 / 100,
                              width: MediaQuery.of(context).size.width * 25 / 100,
                              decoration: const BoxDecoration(
                                color: AppColors.zircon,
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 9.5 / 100,
                                    width: MediaQuery.of(context).size.width * 20 / 100,
                                    child: CircularProgressIndicator(
                                      key: UniqueKey(),
                                      value: _controller.value * 1,
                                      backgroundColor: AppColors.white,
                                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.scienceBlue),
                                      strokeWidth: 5,
                                    ),
                                  ),
                                  Text(
                                    '$secondsLeft s',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: AppColors.scienceBlue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final questionsData = state?.questions?[currentQuestionIndex.value];

                  final option = questionsData?.options?[index];
                  return GestureDetector(
                    onTap: () async {
                      selectedOption.value = option ?? "";
                      answered.value = true;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: AppBoxDecoration.getBorderBoxDecoration(
                        borderRadius: 10,
                        color: AppColors.white,
                        borderColor: selectedOption.value == (option ?? "") ? AppColors.scienceBlue : AppColors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            option ?? "",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.black,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    nextQuestion(currentQuestionIndex.value, selectedOption.value);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.scienceBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Center(
                      child: Text(
                        currentQuestionIndex.value + 1 == _quizController.state?.questions?.length
                            ? "Submit"
                            : " Save & Next",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
