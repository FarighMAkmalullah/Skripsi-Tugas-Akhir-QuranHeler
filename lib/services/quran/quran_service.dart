import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';

class QuranService {
  final _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchQuranData() async {
    try {
      final response = await _dio.get(quranAPI);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load surahs');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
