
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/data/models/notification_model.dart';
import 'package:smart_pager/providers/repository_provider.dart';

part 'notifications_provider.g.dart';


@Riverpod(keepAlive: true)
class Notifications extends _$Notifications {
  @override
  SmartPagerNotificationList? build() => null;

  Future<void> refresh(String id) async {
    final notifications = await ref.read(notificationRepositoryProvider).getNotificationsByUserId(id);
    if (notifications != null) {
      state = notifications;
    }
  }

  Future<bool> haveUnreadNotifications() async {
    final unreadNotifications = state!.notifications.where((element) => !element.isRead).toList();
    return unreadNotifications.isNotEmpty;
  }

  void addNotification(SmartPagerNotification notification) {
    state!.notifications.add(notification);
    state = state!.copy();
  }

  void markNotificationAsRead(String notificationId) {
    ref.read(notificationRepositoryProvider).markNotificationAsRead(state!.id, notificationId);
    final index = state!.notifications.indexWhere((element) => element.id == notificationId);
    state!.notifications[index].isRead = true;
    state = state!.copy();
  }

  void removeNotification(String notificationId) {
    state!.notifications.removeWhere((element) => element.id == notificationId);
    state = state!.copy();
  }

  void clearNotifications() {
    state!.notifications.clear();
    state = state!.copy();
  }

  void updateNotification(SmartPagerNotification notification) {
    final index = state!.notifications.indexWhere((element) => element.id == notification.id);
    state!.notifications[index] = notification;
    state = state!.copy();
  }



}
