
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


  Future<SmartPagerNotification> getNotificationById(String notificationId) async {
    try {
      final querySnapshot = await collection.doc(notificationId).get();
      if (querySnapshot.exists) {
        final notification = itemFromJson(
            querySnapshot.id, querySnapshot.data()!);
        return notification.notifications.first;
      } else {
        throw NotFoundException("Notification with id $notificationId not found");
      }
    } catch (e) {
      print("Error fetching notification: $e");
      throw e;
    }
  }


  Future<SmartPagerNotificationList?> getNotificationsByUserId(String userId) async {
    try {
      final querySnapshot = await collection.doc(userId).get();
      if (querySnapshot!=null && querySnapshot.exists) {

        final notificationList = itemFromJson(
            querySnapshot.id, querySnapshot.data()!);

        return notificationList;
      } else {
        print("Notification with userId $userId not found");
        final newNotificationList = SmartPagerNotificationList(
        id: userId,
        userId: userId,
        notifications: [],
      );
      await createNotificationList(newNotificationList);
        return newNotificationList;
      }
    } catch (e) {
      print("Error fetching notifications: $e");
      
      throw e;
    }
  }

  Future<void> markNotificationAsRead(String userId, String notificationId) async {
    final notificationList = await getNotificationsByUserId(userId);

    if (notificationList != null) {
      final index = notificationList.notifications.indexWhere((element) => element.id == notificationId);
      notificationList.notifications[index].isRead = true;
      await updateNotificationList(userId, notificationList);
    }
  }

}