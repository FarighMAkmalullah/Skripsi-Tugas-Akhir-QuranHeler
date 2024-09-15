import 'package:dio/dio.dart';
import 'package:quranhealer/models/hadist/hadist_mode.dart';

class HadistService {
  final _dio = Dio();

  Future<ApiHadistResponse> fetchHadistData() async {
    try {
      final response = await _dio.get('https://api.hadith.gading.dev/books');

      if (response.statusCode == 200) {
        return ApiHadistResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load hadist');
      }
    } catch (e) {
      throw Exception('Failed to load hadist: $e');
    }
  }
}
