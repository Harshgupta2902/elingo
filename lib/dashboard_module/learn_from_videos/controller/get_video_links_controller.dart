import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocablury/dashboard_module/learn_from_videos/model/video_links_model.dart';
import 'package:vocablury/utilities/dio/api_request.dart';

class GetYouTubeVideoLinksController extends GetxController with StateMixin<VideoLinksModel> {
  getYouTubeVideoLinks() async {
    change(null, status: RxStatus.loading());

    try {
      final response = await getRequest(
        apiEndPoint: "https://run.mocky.io/v3/12ebbeb2-54d5-4817-95b7-e729b5a2d6f5",
      );

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      debugPrint("api success here ");
      final modal = VideoLinksModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("here is the controller error $error");
      change(null, status: RxStatus.error(error.toString()));
    }
  }
}
