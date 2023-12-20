import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class ProfilService {
  static Future<Response> getDetailUser() async {
    String? token = await getToken();
    try {
      final dio = Dio();
      final response = await dio.get("$quranHealerAPI/user",
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load User Detail');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
