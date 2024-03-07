import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocablury/dashboard_module/quiz/model/daily_quiz_model.dart';
import 'package:vocablury/utilities/dio/api_request.dart';

class GetDailyQuizController extends GetxController with StateMixin<DailyQuizModel> {
  RxList<int> selectedAnswers = List.filled(10, -1).obs;
  RxList<bool> isTestSubmitted = RxList<bool>.of(List.filled(10, false));

  final timeLimitInSeconds = 30.obs;
  final restartStream = false.obs;
  final testSubmitted = false.obs;

  Timer? timer;
  final elapsedSeconds = 0.obs;

  // nextQuestion() async {
  //   if (selectedOption.value.isEmpty) {
  //     restartStream.value = false;
  //
  //     return;
  //   }
  //   if (currentQuestionIndex.value < (state?.questions?.length ?? 0) - 1) {
  //     currentQuestionIndex.value++;
  //     selectedOption.value = '';
  //     answered.value = false;
  //     restartStream.value = true;
  //
  //     timeLimitInSeconds.value = 30;
  //   } else {
  //     debugPrint("end of quiz");
  //   }
  // }

  getQuizQuestions({required String apiUrl}) async {
    change(null, status: RxStatus.loading());

    try {
      final response = await getRequest(
        apiEndPoint: apiUrl,
      );

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = DailyQuizModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("Error in fetching daily quiz questions: $error");
      change(null, status: RxStatus.error(error.toString()));
    }
  }
}
