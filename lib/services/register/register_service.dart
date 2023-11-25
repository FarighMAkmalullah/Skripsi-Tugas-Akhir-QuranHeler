import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';

class RegisterService {
  Future postRegister({
    required String name,
    required String email,
    required String gender,
    required String password,
  }) async {
    print(
        {"name": name, "email": email, "gender": gender, "password": password});
    try {
      Response response = await Dio().post('$quranHealerAPI/register',
          options: Options(headers: {
            "Content-Type": 'text/plain',
          }),
          data:
              '''{\r\n    "name": "$name",\r\n    "email": "$email",\r\n    "gender": "$gender",\r\n    "password": "$password"\r\n}''');
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
