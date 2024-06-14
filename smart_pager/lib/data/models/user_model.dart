
import 'package:smart_pager/data/models/generic_model.dart';
import 'package:smart_pager/data/models/restaurant_model.dart';

class SmartPagerUser extends GenericModel<SmartPagerUser> {
  final String email;
  String name;
  String? phoneNumber;
  String? currentRestaurantSlug;
  int? commensalsAmount;
  String? description;
  bool? isInQueue;

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
      'currentRestaurantSlug': currentRestaurantSlug,
      'commensalsAmount': commensalsAmount,
      'description': description,
      'isInQueue': isInQueue,
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