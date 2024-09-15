import 'dart:convert';

import 'package:quranhealer/core/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';
import 'package:quranhealer/models/notification/notification_model.dart';

class NotificationService {
  static Future<ApiNotification> fetchNotificationData() async {
    String? token = await getToken();
    try {
      final dio = Dio();
      final response = await dio.get("$quranHealerAPI/notif",
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      if (response.statusCode == 200) {
        return ApiNotification.fromJson(response.data);
      } else {
        throw Exception('Failed to load Notification Data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
