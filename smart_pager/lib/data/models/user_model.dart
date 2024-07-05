
import 'package:smart_pager/data/models/current_queue_model.dart';
import 'package:smart_pager/data/models/generic_model.dart';

class SmartPagerUser extends GenericModel<SmartPagerUser> {
  final String email;
  String name;
  String? phoneNumber;
  String? description;
  // SmartPagerCurrentQueue? currentQueue;

  SmartPagerUser({
    required super.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    // this.currentQueue,
  });

  get fullName => "$name";

  Object? get state => null;

  @override
  static SmartPagerUser fromJson(Map<String, dynamic> json) {
    return SmartPagerUser(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      // currentQueue: json['currentQueue'] != null
      //     ? SmartPagerCurrentQueue.fromJson(json['currentQueue'])
      //     : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'description': description,
      // 'currentQueue': currentQueue?.toJson(),
    };
  }

  SmartPagerUser copy() {
    return SmartPagerUser(
      id: id,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}