import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class EditCommentService {
  Future editComment({
    required String comment,
    required int idComment,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().put('$quranHealerAPI/comment/$idComment',
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
