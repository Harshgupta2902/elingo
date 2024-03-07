import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vocablury/utilities/dio/api_end_points.dart';



class NewClient {
  Dio init() {
    Dio dio = Dio();

    final prefs = GetStorage();

    // var token = prefs.read('TOKEN');
    dio.options.headers["Authorization"] ;
    // dio.options.headers["device"] = Platform.isAndroid ? 'Android' : 'IOS';
    dio.options.baseUrl = APIEndPoints.base;

    RequestOptions? requestOptions;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          requestOptions = options;

          return handler.next(options);
        },
        onError: (e, handler) {
          // final crashlytics = FirebaseCrashlytics.instance;
          //
          // crashlytics.recordError("API EXCEPTION DIO: ${requestOptions?.path}", e.stackTrace, fatal: true);
          // crashlytics.setCustomKey("api_end_point", '${requestOptions?.path}');
          // crashlytics.setCustomKey("request_method", '${requestOptions?.method}');
          // if (requestOptions?.method == 'POST') {
          //   crashlytics.setCustomKey("request_post", '${requestOptions?.data}');
          // }

          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}
