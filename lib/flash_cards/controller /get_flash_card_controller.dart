import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocablury/flash_cards/model/flash_card_data_model.dart';
import 'package:vocablury/utilities/dio/api_request.dart';

class GetFlashCardDataController extends GetxController with StateMixin<FlashCardDataModel> {
  RxList likedCardList = [].obs;
  RxList flashCards = [].obs;

  void getFlashCardData() async {
    change(null, status: RxStatus.loading());

    try {
      final response = await getRequest(
        apiEndPoint: "https://run.mocky.io/v3/481dc78a-b0b8-425f-8fa8-512d9c578962",
      );

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = FlashCardDataModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("Error in fetching quiz questions: $error");
      change(null, status: RxStatus.error(error.toString()));
    }
  }
}
