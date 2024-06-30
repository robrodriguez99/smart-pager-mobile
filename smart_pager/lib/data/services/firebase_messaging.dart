
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smart_pager/data/models/notification_model.dart';
import 'package:smart_pager/data/models/user_model.dart';
import 'package:smart_pager/data/repositories/notification_repository_impl.dart';
import 'package:smart_pager/data/repositories/user_repository_impl.dart';
import 'package:smart_pager/data/services/firebase_auth.dart';

import 'package:smart_pager/data/services/access_firebase_token.dart';
  
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
    print(message.notification?.title);
  }

class FirebaseMessagingApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseMessagingApi();

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    initPushNotifications();
  }

  //get the token
  Future<String> getToken() async {
    return await _firebaseMessaging.getToken() ?? '';
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

  void handleForegroundMessage() async {
    FirebaseMessaging.onMessage.listen((message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.notification?.title}');
      //TODO: show a dialog or snackbar to the user

      handleMessage(message);
    });
  }

  
  void handleMessage(RemoteMessage? message) async {
    print('Handling a message ${message?.messageId}');
    if (message == null) {
      print('No message');
      return;
    }

    if (message.notification != null) {
      final notification = SmartPagerNotification(
        id: message.messageId ?? '',
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        date: DateTime.now(),
      );
      final currentFirebaseUser = await MyFirebaseAuth().currentUser();
      final SmartPagerUser smartPagerUser = await UserRepositoryImpl().getUserByEmail(currentFirebaseUser!.email);
      await NotificationRepositoryImpl().insertNotification(smartPagerUser.id, notification);
    }
  }
}
