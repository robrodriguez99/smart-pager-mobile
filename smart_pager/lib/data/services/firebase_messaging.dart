
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  print(message.notification?.title);
}

class FirebaseMessagingApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseMessagingApi();

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    print('FirebaseMessaging token: $token');
    initPushNotifications();
    
  }


  Future initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    
    handleForegroundMessage();


  }

  void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.notification?.title}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  
  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      print('No message');
      return;
    }
    print('A new onMessage event was published');
    print(message.category);
  }





}
