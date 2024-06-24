
import 'package:smart_pager/data/models/notification_model.dart';
import 'package:smart_pager/data/repositories/repository.dart';
import 'package:smart_pager/exceptions/not_found_exception.dart';

class NotificationRepositoryImpl extends Repository<SmartPagerNotificationList> {
  NotificationRepositoryImpl() : super('Notifications');

  Future<SmartPagerNotificationList> createNotificationList(SmartPagerNotificationList notification) async {
    return await create(notification);
  }

  //insert notifications
  Future<void> insertNotification(String uid, SmartPagerNotification notification) async {
    // first we check if the user has a notification list
    final notificationList = await getNotificationsByUserId(uid);

    if (notificationList != null) {
      notificationList.notifications.add(notification);
      await updateNotificationList(uid, notificationList);
    } else {
      final newNotificationList = SmartPagerNotificationList(
        id: uid,
        userId: uid,
        notifications: [notification],
      );
      await createNotificationList(newNotificationList);
    }
  
  }

  Future<void> updateNotificationList(String uid, SmartPagerNotificationList notificationList) async {
    await collection.doc(uid).update(notificationList.toJson());
  }

  @override
  SmartPagerNotificationList itemFromJson(String id, Map<String, dynamic> json) {
    String notificationId = id;
    String userId = json['userId'];
    List<SmartPagerNotification> notifications = json['notifications']
        .map<SmartPagerNotification>((e) => SmartPagerNotification.fromJson(e))
        .toList();
    return SmartPagerNotificationList(
      id: notificationId,
      userId: userId,
      notifications: notifications,
    );
  }

  Future<SmartPagerNotificationList?> getNotificationsByUserId(String userId) async {
    try {
      
      final querySnapshot =
          await collection.where('userId', isEqualTo: userId).get();
      if (querySnapshot.docs.isNotEmpty) {
        final notificationList = itemFromJson(
            querySnapshot.docs.first.id, querySnapshot.docs.first.data());
        return notificationList;
      } else {
        // throw NotFoundException("Notification with userId $userId not found");
        print("Notification with userId $userId not found");
        return null;
      }
    } catch (e) {
      print("error $e");
      // Rethrow the exception or handle it as needed.
      throw e;
    }
  }

}