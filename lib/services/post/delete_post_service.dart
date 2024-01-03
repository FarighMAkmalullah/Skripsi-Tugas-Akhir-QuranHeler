import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class DeletePostService {
  Future deletePost({
    required int idPost,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().delete(
        '$quranHealerAPI/post/$idPost',
        options: Options(
          headers: {
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
