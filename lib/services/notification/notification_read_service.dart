import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/const/api.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';

class NotivicationReadService {
  static Future<Map<String, dynamic>> fetchNotificationReadData({
    required int idNotif,
  }) async {
    String? token = await getToken();
    try {
      final response = await Dio().get('$quranHealerAPI/notif/$idNotif',
          options: Options(headers: {
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          }));
      return response.data;
    } catch (error) {
      throw Exception('Failed to load notification data: $error');
    }
  }
}
