import 'package:smart_pager/data/models/generic_model.dart';

class SmartPagerNotification extends GenericModel<SmartPagerNotification> {

  final String title;
  final String body;
  final DateTime date;
  bool isRead;

  SmartPagerNotification({
    required super.id,
    required this.title,
    required this.body,
    required this.date,
    this.isRead = false,
  });
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'isRead': isRead,
      'date': date.toIso8601String(),
    };
  }

  static SmartPagerNotification fromJson(Map<String, dynamic> json) {
    return SmartPagerNotification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      date: DateTime.parse(json['date']),
      isRead: json['isRead'],
    );
  }

  SmartPagerNotification copy() {
    return SmartPagerNotification(
      id: id,
      title: title,
      body: body,
      date: date,
      isRead: isRead,
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

  static SmartPagerNotificationList fromJson(Map<String, dynamic> json) {
    return SmartPagerNotificationList(
      id: json['id'],
      userId: json['userId'],
      notifications: json['notifications']
          .map<SmartPagerNotification>((e) => SmartPagerNotification.fromJson(e))
          .toList(),
    );
  }

  SmartPagerNotificationList copy() {
    return SmartPagerNotificationList(
      id: id,
      userId: userId,
      notifications: notifications.map((e) => e.copy()).toList(),
    );
  }
}
