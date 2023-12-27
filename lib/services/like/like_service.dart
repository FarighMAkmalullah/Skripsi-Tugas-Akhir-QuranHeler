import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class LikeService {
  Future likeAdd({
    required int idPost,
  }) async {
    String? token = await getToken();
    print(idPost);
    try {
      Response response = await Dio().get(
        '$quranHealerAPI/post/$idPost/like',
        options: Options(
          headers: {
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      print(e);
      return e.response?.data;
    }
  }
}
