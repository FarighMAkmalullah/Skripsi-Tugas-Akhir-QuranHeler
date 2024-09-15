import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

class AccessTokenFirebase {
  // add endpoint url
  static String firebaseMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccesToken() async {
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(
          {
            "type": "service_account",
            "project_id": "quranhealerapp",
            "private_key_id": "0b4a44c2c0404243ba922c60f8535c4a2bcc8b5b",
            "private_key":
                "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDDw78jP+pTiXkQ\nNK6FiACR0OTZdVGS1kXeJOgWGUo0VdaoYgR5Vok4b6Y6SL8BYc4pBAsR3794muWN\nKEvSptHB9rPZAsrjKjJxKcjYM/4hQ3GCwtepYr9JFOQzDBFqDMlLPKBzU8C6MU7d\nS/e9BOXIyOO7ZLlZjJoZiBpMJF/tv1wtqi7wPu6solSgXjdhcZuQhgi5cSGAw3uF\nZ8FjnRlGzvBP62wPOAZvSthf16WWI50eAskhH2ZyXZYuzW3PusRJ2dLaMtPgg24W\nM272YesAjFxTnMYJEape2IbsJAVqbr+Bu5IpB90cI9Jo9LzoLF+cIwYi+apjd2VK\ntVG65u95AgMBAAECggEAAUuvnWpcIOrpQfXzTL9yb4SgKx9HZ68i3b5FSfYnY1LJ\nHaquaGYt+NFmWn7mQrpUvLlB4H+oWwI9cDJ60/1WKJA7Lv3BfYDnPg/+fA3WCf7S\nBsFG36Bfbzqj6wGSsO6+O1D+p9y/Swwt/zF0RYw9gBdySGh5gJH5aB9aOzRHbUGi\nwRVrCdqqag4wD4X8vabdGDW3BrUdklngMW6/QlhMVBMHDVNZ0x6lhAOk58aLTcKs\nuDNvNXRNEgFr5Xc3ZCJdxIqbQLZSFOWPKnt9vAtejUjkXaaZb8jf3XxtD6U7x6Ko\n6g4iyXvhzjXdm9SGk++apOzfGTxar+wMrEP+mwoGAQKBgQDsR5K3SJIS8+W7parQ\nTm66FTvBC4hAVifDLXjXqN11RvoqJS8yS2n4GHqDaPPYodLotVdSVqGV+fQaxdoZ\n4Ox3oZ0v8AFjf1fHQdMjqjuc9NJdP1zBhlJq0dNqpt+2Ki04V2Zi8lhaFpqqOBAP\nsQ+bvE0EwPot0Ocjk79BELfLAQKBgQDUGoSVJuQIAPno+X37If/ukfpQ34zwPH4v\nFk8AsWtJeofTYrbTPBNTJnhwdMe4HhWyRN8o8zWly3zee590xvZ9ssmFXT03l4iS\nS6bXvpZi6DMxqeMCXa0C16f6cHkHeKfmD5i1RCkR8YPzseuqbzjAnGVpDCbHzsWd\nKFQhdzP8eQKBgQDDMK1ndDAYMBxM1CM0Slb2qqveYiSA4aufdWUq43lvdN8dCfLf\nXaWBKteqz30CLU0KqSQmBSMfvomFxITUdBdlDMHJ5D+BbqWZGivOfscYdreCCOIb\njVdwnz5EEO8mkdkhfjI683FBmwLSM9Yw4FjAkuIdVz5Vswn/PgL1QVZUAQKBgHGC\nk4vC2WxTIWuGAd7hTjdd1ilryeBTb3BBrxv+1xzmv0PoY1FeqDTqtK/yP2QQbaoO\n46LlrcNByFzEqgxz4jxY7zI5OObEaOlqJSr2q0LZY3Rjp8J/YXTQ9uu3P345Gxmr\nJR11Ecmxh91mTWnTxfqGeFskjqiFxwoZKBUU1zR5AoGBANE3h3OsUtJNP5tmNNDR\nysBWMYVfbihIOh7AalDSSUykzo/BvR6dZvmBVvOigfaQl/5QWksqaxFPIWIBjqGR\n1XQZggMtmI2kIaQutsb1rhjgJTaCrDDr7684gFpMyE1qFbCOVMwmyN3rwDeYOo2r\nLqFyt17dFoKa//ZZL04VSpG/\n-----END PRIVATE KEY-----\n",
            "client_email":
                "firebase-adminsdk-30fgu@quranhealerapp.iam.gserviceaccount.com",
            "client_id": "107092448922038007003",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url":
                "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url":
                "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-30fgu%40quranhealerapp.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          },
        ),
        [firebaseMessagingScope]);

    //Extract access token from the credentials
    final accessToken = client.credentials.accessToken.data;
    //return access token
    return accessToken;
  }
}
