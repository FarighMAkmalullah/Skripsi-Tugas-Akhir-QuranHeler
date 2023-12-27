import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class JawabanService {
  static Future<List<Map<String, dynamic>>> fetchJawabanData({idPost}) async {
    String? token = await getToken();
    try {
      final dio = Dio();
      final response = await dio.get("$quranHealerAPI/post/$idPost",
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["result"]['comment'];
        return data
            .map<Map<String, dynamic>>(
                (item) => Map<String, dynamic>.from(item))
            .toList();
      } else {
        throw Exception('Failed to load Post Data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
