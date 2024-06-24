import 'package:smart_pager/data/models/generic_model.dart';

class SmartPagerNotification extends GenericModel<SmartPagerNotification> {

  final String title;
  final String body;
  bool isRead = false;

  SmartPagerNotification({
    required super.id,
    required this.title,
    required this.body,
  });
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'isRead': isRead,
    };
  }

  static SmartPagerNotification fromJson(Map<String, dynamic> json) {
    return SmartPagerNotification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class SmartPagerNotificationList extends GenericModel<SmartPagerNotificationList> {
  final String userId;
  final List<SmartPagerNotification> notifications;

  SmartPagerNotificationList({
    required super.id,
    required this.userId,
    required this.notifications,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'notifications': notifications.map((e) => e.toJson()).toList(),
    };
  }
}
