import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/const/api.dart';

class DetailAdzanService {
  static final Dio _dio = Dio();

  static Future<Response> getDetailAdzan(String kode, String tanggal) async {
    try {
      final response = await _dio.get("$adzanAPI/sholat/jadwal/$kode/$tanggal");
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
