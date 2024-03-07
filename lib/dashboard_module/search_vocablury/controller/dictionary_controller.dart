import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocablury/dashboard_module/search_vocablury/model/dictionary_data_model.dart';
import 'package:vocablury/utilities/dio/api_request.dart';

class DictionaryController extends GetxController with StateMixin<DictionaryDataModel> {
  final TextEditingController inputController = TextEditingController();

  final isLoading = false.obs;

  getDictionary(String word) async {
    change(null, status: RxStatus.loading());

    try {
      isLoading.value = true;
      final response = await getRequest(
        apiEndPoint: '  ',
      );

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';

      }
      debugPrint("api success here ${response.data} ");

      final modal = DictionaryDataModel.fromJson(response.data);

      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("here is the DictionaryController error $error");
      change(null, status: RxStatus.error(error.toString()));
    } finally {
      isLoading.value = false;
    }
  }
}
