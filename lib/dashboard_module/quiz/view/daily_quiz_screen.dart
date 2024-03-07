import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/dashboard_module/quiz/controller/daily_quiz_controller.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

final _quizController = Get.put(GetDailyQuizController());

class DailyQuizScreen extends StatefulWidget {
  final String apiUrl;
  final int? completedIndex;

  const DailyQuizScreen({
    Key? key,
    required this.apiUrl,
    this.completedIndex,
  }) : super(key: key);

  @override
  State<DailyQuizScreen> createState() => DailyQuizScreenState();
}

class DailyQuizScreenState extends State<DailyQuizScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  final selectedOption = "".obs;
  final currentQuestionIndex = 0.obs;
  final answered = false.obs;
  final secondsLeft = 30.obs;
  Timer? timer;
  Map<int, Map<String, String>> answerStatus = {};

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
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (secondsLeft.value < 0) {
          timer.cancel();
          debugPrint("timer End here");

          _updateAnswerStatus(currentQuestionIndex.value, "Not Attempted", false);
          debugPrint("here is the restart  updated index ${currentQuestionIndex.value}");

          currentQuestionIndex.value++;
          selectedOption.value = '';
          answered.value = false;
          debugPrint("here is the restart after   updated index ${currentQuestionIndex.value}");

          _restartTimer();
          debugPrint("answer status: $answerStatus");
          return;
        }

        if (secondsLeft.value == 0 &&
            currentQuestionIndex.value + 1 == _quizController.state?.questions?.length &&
            answered.value == false) {
          _updateAnswerStatus(currentQuestionIndex.value, "Not Attempted", false);
          debugPrint("function called  End here");
          List<int> selectedAnswers = answerStatus.entries.map((entry) {
            String? option = entry.value['option'];
            int index = _quizController.state?.questions?[entry.key].options?.indexOf(option!) ?? -1;
            return index;
          }).toList();

          timer.cancel();
          _quizController.testSubmitted.value = true;
          context.push(
            GoPaths.testResultPage,
            extra: {
              "questions": _quizController.state?.questions ?? [],
              "selectedAnswers": selectedAnswers,
              "correctCount": answerStatus.values.where((value) => value['result'] == 'Correct!').length,
              "totalTimeInSeconds": (_quizController.state?.questions?.length ?? 0) * 10,
            },
          );
          return;
        }
        if (secondsLeft > 0) {
          secondsLeft.value--;
        }
      },
    );
  }

  _restartTimer() {
    _controller.reset();
    _controller.forward();

    secondsLeft.value = 30;
    debugPrint("timer restarted here ");
  }

  void _updateAnswerStatus(int questionIndex, String option, bool isCorrect) {
    setState(() {
      answerStatus[questionIndex] = {
        'option': option,
        'result': isCorrect ? 'Correct!' : 'Wrong!',
      };
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
      debugPrint("Select an option before proceeding");
      return;
    }

    selectedOption.value = option;
    answered.value = true;
    debugPrint("button tapped here ");
    bool isCorrect = option == _quizController.state?.questions?[currentQuestionIndex.value].correctAnswer;

    final lastIndex = _quizController.state?.questions?.length ?? 0;

    if (index >= lastIndex - 1) {
      _updateAnswerStatus(currentQuestionIndex.value, option, isCorrect);
      List<int> selectedAnswers = answerStatus.entries.map((entry) {
        String? option = entry.value['option'];
        int index = _quizController.state?.questions?[entry.key].options?.indexOf(option!) ?? -1;
        return index;
      }).toList();

      timer?.cancel();
      _quizController.testSubmitted.value = true;
      await context.push(
        GoPaths.testResultPage,
        extra: {
          "questions": _quizController.state?.questions ?? [],
          "selectedAnswers": selectedAnswers,
          "correctCount": answerStatus.values.where((value) => value['result'] == 'Correct!').length,
          "totalTimeInSeconds": (_quizController.state?.questions?.length ?? 0) * 10,
        },
      );

      debugPrint("end Quiz ");
      return;
    }

    if (index < lastIndex - 1) {
      _updateAnswerStatus(currentQuestionIndex.value, option, isCorrect);
      currentQuestionIndex.value++; // Update currentQuestionIndex
      selectedOption.value = ''; // Reset selectedOption
      answered.value = false;

      _restartTimer();
      debugPrint("here is the next tap updated map $answerStatus");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteSmoke,
      appBar: CustomAppBar(
        title: "",
        isProfileView: false,
        leadingIconColor: AppColors.white,
        bgColor: AppColors.scienceBlue,
        actionOnTap: () {
          SystemNavigator.pop();
        },
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
                      if (!answered.value) {
                        await checkAnswer(option ?? "");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: AppBoxDecoration.getBorderBoxDecoration(
                        color: AppColors.zircon,
                        showShadow: true,
                        borderColor:
                            answered.value && option == state?.questions?[currentQuestionIndex.value].correctAnswer
                                ? Colors.green
                                : answered.value &&
                                        option != state?.questions?[currentQuestionIndex.value].correctAnswer &&
                                        selectedOption.value == option
                                    ? Colors.red
                                    : AppColors.lemonGrass.withOpacity(0.5),
                        borderWidth: 2.0,
                        shadowColor: AppColors.lemonGrass.withOpacity(0.3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            option ?? "",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.black,
                                ),
                          ),
                          assetIcon(
                            answered.value && option == state?.questions?[currentQuestionIndex.value].correctAnswer
                                ? AssetPath.check
                                : answered.value &&
                                        option != state?.questions?[currentQuestionIndex.value].correctAnswer &&
                                        selectedOption.value == option
                                    ? AssetPath.wrong
                                    : "",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    nextQuestion(currentQuestionIndex.value, selectedOption.value);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.scienceBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Center(
                      child: Text(
                        currentQuestionIndex.value - 2 == state?.questions?.length ? "Submit" : "Next",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
