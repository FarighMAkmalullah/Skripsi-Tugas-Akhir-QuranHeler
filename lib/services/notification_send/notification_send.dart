import 'dart:convert';
import 'package:quranhealer/core/init/const/access_firebase_token.dart';
import 'package:dio/dio.dart';

class NotificationSend {
  Future send(
      {required String tokenMobile,
      required String judul,
      required String body,
      required String to,
      required String emailUstadz,
      required int idUstadz}) async {
    AccessTokenFirebase accessTokenGetter = AccessTokenFirebase();
    String token = await accessTokenGetter.getAccesToken();
    try {
      Response response = await Dio().post(
          'https://fcm.googleapis.com/v1/projects/quranhealerapp/messages:send',
          options: Options(
            headers: {
              "Content-Type": 'text/plain',
              "Authorization": "Bearer $token",
            },
          ),
          data: json.encode({
            "message": {
              "token": tokenMobile,
              "notification": {
                "title": judul,
                "body": body,
                "image": "https://example.com/image.png"
              },
              "data": {
                "to": to,
                "email": emailUstadz,
                'user_id': idUstadz.toString(),
              }
            }
          }));
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
