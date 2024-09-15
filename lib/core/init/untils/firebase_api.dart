import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:quranhealer/main.dart';
import 'package:quranhealer/screens/curhat/chat_screen.dart';
import 'package:quranhealer/screens/ustadz/chat_ustadz_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}

class FirebaseApi {
  //  create an intance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;
  // function to initialize notification
  Future<String> initNotification() async {
    //request permition from user (will prompt user)
    await _firebaseMessaging.requestPermission();
    //  fetch the handle FCM token for this device
    final fCMtoken = await _firebaseMessaging.getToken();

    // print the token
    print('Token Android: ' + fCMtoken.toString());
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotification();
    return fCMtoken.toString();
  }
  // fuction to handle received messaging

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    } else {
      if (message.notification!.title == 'Notifikasi Post') {
        navigatorKey.currentState?.pushNamed(
          '/notification_screen',
          arguments: message,
        );
      } else if (message.notification!.title != 'Notifikasi Post' &&
          message.data['to'] == 'ustadz') {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => ChatUstadzScreen(
                email: message.data['email'],
                idUser: int.parse(message.data['user_id'])),
          ),
        );
      } else if (message.notification!.title != 'Notifikasi Post' &&
          message.data['to'] == 'user') {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          ),
        );
      }
    }
  }

  // fuction to initialize foreground and background settings

  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
