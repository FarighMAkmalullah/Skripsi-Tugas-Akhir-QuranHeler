import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';
import 'package:quranhealer/models/jawaban/detail_post_model.dart';

class PersonalPostService {
  final String _baseUrl = 'https://quranhealer.vercel.app';

  final Dio _dio = Dio();

  Future<PostDetail> fetchPost({required int idPost}) async {
    String? token = await getToken();
    try {
      final response = await _dio.get('$_baseUrl/post/$idPost',
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      if (response.statusCode == 200) {
        print("response : ${response.data}");
        return PostDetail.fromJson(response.data["result"]);
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      throw Exception('Failed to load post: $e');
    }
  }
}
