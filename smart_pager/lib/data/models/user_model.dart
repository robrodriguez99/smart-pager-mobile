
import 'package:smart_pager/data/models/generic_model.dart';

class SmartPagerUser extends GenericModel<SmartPagerUser> {
  final String email;
  final String name;
  String? phoneNumber;

  SmartPagerUser({
    required super.id,
    required this.email,
    required this.name,
    this.phoneNumber,
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
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
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