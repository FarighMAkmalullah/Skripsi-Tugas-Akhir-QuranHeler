import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class EditProfilService {
  Future postEditProfil({
    required String name,
    required String email,
    required String gender,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().put(
          'https://quranhealer.vercel.app/user/edit',
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          }),
          data:
              '''{\r\n    "name": "$name",\r\n    "email": "$email",\r\n    "gender": "$gender",\r\n}''');
      print(response.data);
      return response.data;
    } on DioException catch (e) {
      print(e.response?.data);
      return e.response?.data;
    }
  }
}
