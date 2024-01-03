import 'package:flutter/material.dart';
import 'package:quranhealer/models/notification/notification_model.dart';
import 'package:quranhealer/models/post/post_model.dart';
import 'package:quranhealer/services/notification/notification_service.dart';
import 'package:quranhealer/services/post/post_service.dart';

class NotificationViewModel extends ChangeNotifier {
  List<NotificationModel?> _listNotification = [];
  List<NotificationModel?> get notificationData => _listNotification;

  Future getNotificationPostData() async {
    try {
      final List<Map<String, dynamic>> notificationData =
          await NotificationService.fetchNotificationData();

      _listNotification = notificationData
          .map((item) => NotificationModel.fromJson(item))
          .toList();

      notifyListeners();
    } catch (error) {
      throw Exception('Gagal memuat all data notification : $error');
    }
  }

  void clearAllPost() {
    _listNotification.clear();
  }

  @override
  notifyListeners();
}
