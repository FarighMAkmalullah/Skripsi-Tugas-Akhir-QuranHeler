import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class EditPasswordService {
  Future postEditPassword({
    required String newPassword,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().put('$quranHealerAPI/user/edit',
          options: Options(headers: {
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          }),
          data: '''{\r\n  "password": "$newPassword"\r\n}''');
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
