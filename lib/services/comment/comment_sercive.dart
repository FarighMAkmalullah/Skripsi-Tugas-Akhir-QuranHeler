import 'dart:ui';

import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class CommentService {
  Future postComment({
    required String comment,
    required int idPost,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().post('$quranHealerAPI/post/$idPost',
          options: Options(headers: {
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          }),
          data: '''{\r\n    "comment": "$comment" \r\n}''');
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
