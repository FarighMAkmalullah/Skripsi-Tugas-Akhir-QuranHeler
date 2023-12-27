import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class AddPostService {
  Future postAdd({
    required String judul,
    required String konten,
    required int idUstadz,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().post(
          '$quranHealerAPI/post?ustadz=$idUstadz',
          options: Options(headers: {
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          }),
          data:
              '''{\r\n    "username": "Anonymous",\r\n    "judul": "$judul",\r\n    "konten": "$konten" \r\n}''');
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
