import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class EditProfilService {
  Future postEditProfil({
    required String oldPassword,
    required String newPassword,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().put('$quranHealerAPI/user/password',
          options: Options(headers: {
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          }),
          data:
              '''{\r\n    "oldPassword": "$oldPassword",\r\n    "newPassword": "$newPassword",\r\n}''');
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
