import 'package:dio/dio.dart';

class HadistService {
  static final Dio _dio = Dio();

  static Future<Response> getDetailHadist({
    required String hadist,
    required int nomorAwal,
    required int nomorAkhir,
  }) async {
    try {
      final response = await _dio.get(
          "https://api.hadith.gading.dev/books/$hadist?range=$nomorAwal-$nomorAkhir");
      print("Hadist Service : $response");
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
