import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';

class QuranService {
  final _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchQuranData() async {
    try {
      final response = await _dio.get("$quranAPI/api/v2/surat");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data
            .map<Map<String, dynamic>>(
                (item) => Map<String, dynamic>.from(item))
            .toList();
      } else {
        throw Exception('Failed to load Quran');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
