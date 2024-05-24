import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocablury/utilities/dio/api_request.dart';
import 'package:vocablury/utilities/fcm_services/FcmModel.dart';

class FcmTokenController extends GetxController with StateMixin<FcmModel> {
  fcmTokenApi({required String? fcmToken}) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    change(null, status: RxStatus.loading());

    final data = {
      'loginId': sharedPref.getString("LoginId"),
      'fcm_token': fcmToken.toString(),
    };
    try {
      final response = await postRequest(
        postData: data,
        apiEndPoint: "https://run.mocky.io/v3/551b73e4-3b96-4fe7-a040-07d9fa65825e",
      );

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = FcmModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("Error in fetching getAudios: $error");
      change(null, status: RxStatus.error(error.toString()));
    }
  }
}
