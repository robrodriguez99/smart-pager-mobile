

import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class AccessTokenFirebase {

  static String firebaseMessagingScope = 'https://www.googleapis.com/auth/firebase.messaging';  

  Future<String> getAccessToken() async {

  // load the .env file
  await dotenv.load(fileName: ".env");

  

  // define the json credentials
  Object json = { 
    "type": "service_account",
    "project_id": dotenv.env["PROJECT_ID"]!.toString(),
    "private_key_id": dotenv.env["PRIVATE_KEY_ID"]!.toString(),
    "private_key": dotenv.env["PRIVATE_KEY"]!,
    "client_email": dotenv.env["CLIENT_EMAIL"]!.toString(),
    "client_id": dotenv.env["CLIENT_ID"]!.toString(),
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": dotenv.env["CLIENT_X509_CERT_URL"]!.toString(),
    "universe_domain": "googleapis.com"
  };



    final credentials = ServiceAccountCredentials.fromJson(json);

    final client = await clientViaServiceAccount(credentials, [firebaseMessagingScope]);

    final accessToken = client.credentials.accessToken.data;

    return accessToken;
  }

  void longPrint(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

}