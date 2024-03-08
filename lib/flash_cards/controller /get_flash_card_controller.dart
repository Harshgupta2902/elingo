import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocablury/flash_cards/model/flash_card_data_model.dart';
import 'package:vocablury/utilities/dio/api_request.dart';

class GetFlashCardDataController extends GetxController with StateMixin<FlashCardDataModel> {
  RxList likedCardList = [].obs;
  RxList flashCards = [].obs;

  void getFlashCardData(String categoryName) async {
    change(null, status: RxStatus.loading());

    try {
      final response = await postRequest(
        postData: {"category_name": categoryName},
        apiEndPoint: "http://10.0.20.125/learnAPi/Api/flashCardData",
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

//------------------------------ GetFlashCardListDataController ----------------------------------
class GetFlashCardListDataController extends GetxController with StateMixin<GetFlashCardListData> {
  RxList likedCardList = [].obs;
  RxList flashCards = [].obs;

  void getFlashCardListData() async {
    change(null, status: RxStatus.loading());

    try {
      final response = await getRequest(
        apiEndPoint: "http://10.0.20.125/learnAPi/Api/getCategoryNameList",
      );

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = GetFlashCardListData.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("Error in fetching quiz questions: $error");
      change(null, status: RxStatus.error(error.toString()));
    }
  }
}
