import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';

class LoginService {
  Future postLogin({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await Dio().post('$quranHealerAPI/login',
          options: Options(headers: {
            "Content-Type": 'text/plain',
          }),
          data:
              '''{\r\n    "email": "$email",\r\n    "password": "$password"\r\n}''');
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
