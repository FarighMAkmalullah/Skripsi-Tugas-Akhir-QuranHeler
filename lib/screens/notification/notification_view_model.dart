import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quranhealer/models/notification/notification_model.dart';
import 'package:quranhealer/services/notification/notification_service.dart';
import 'package:rxdart/rxdart.dart';

class NotificationViewModel extends ChangeNotifier {
  final notificationController = BehaviorSubject<List<NotificationModel>>();
  late Timer timer1;
  Stream<List<NotificationModel>> get notificationStream =>
      notificationController.stream;

  bool _isTimerActive = false;

  StreamSubscription<List<NotificationModel>>? subscription;

  final _blmDibacaSubject = BehaviorSubject<String>();

  Stream<String> get blmDibacaStream => _blmDibacaSubject.stream;

  Future<void> getNotificationData() async {
    try {
      final notificationData =
          await NotificationService.fetchNotificationData();
      notificationController.add(notificationData.result);
    } catch (error) {
      throw Exception('Error loading notificaion data: $error');
    }
  }

  void fetchBlmDibaca() async {
    try {
      final apiResponse = await NotificationService.fetchNotificationData();
      _blmDibacaSubject.add(apiResponse.blmDibaca);
    } catch (e) {
      _blmDibacaSubject.addError(e);
    }
  }

  void cancelTimer() {
    if (_isTimerActive) {
      timer1.cancel();
      _isTimerActive = false;
    }
  }

  @override
  void dispose() {
    _blmDibacaSubject.close();
    notificationController.close();
    subscription?.cancel();
    if (_isTimerActive) {
      timer1.cancel();
    }
    super.dispose();
  }
}
