import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/const/api.dart';

class DetailService {
  static final Dio _dio = Dio();

  static Future<Response> getDetailSurah(int? nomor) async {
    try {
      final response = await _dio.get("$quranAPI/api/v2/surat/$nomor");
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
