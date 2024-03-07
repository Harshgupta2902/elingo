import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocablury/dashboard_module/quiz/model/get_quiz_questions_model.dart';
import 'package:vocablury/utilities/dio/api_request.dart';

class GetQuizQuestionsController extends GetxController with StateMixin<GetQuizQuestionsModel> {
  RxList<int> selectedAnswers = List.filled(10, -1).obs;

  void getQuizQuestions() async {
    change(null, status: RxStatus.loading());

    try {
      final response = await getRequest(
        apiEndPoint: "https://run.mocky.io/v3/9f42f0bb-cde5-45bd-95c3-94a6c1cbb0fd",
      );

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = GetQuizQuestionsModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("Error in fetching quiz questions: $error");
      change(null, status: RxStatus.error(error.toString()));
    }
  }
}
