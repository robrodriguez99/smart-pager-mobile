
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  print(message.data);
}

class FirebaseMessagingApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseMessagingApi();

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    print('FirebaseMessaging token: $token');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }



}
