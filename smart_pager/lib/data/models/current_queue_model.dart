import 'package:smart_pager/data/models/generic_model.dart';
import 'package:smart_pager/data/models/restaurant_model.dart';

class SmartPagerCurrentQueue extends GenericModel<SmartPagerCurrentQueue> {
  final String email;
  SmartPagerRestaurant restaurant;
  int waitingTime;
  bool isCalled;
  // int? commensalsAmount;


  SmartPagerCurrentQueue({
    required super.id,
    required this.email,
    required this.restaurant,
    required this.waitingTime,
    required this.isCalled,
  });

  Object? get state => null;

  @override
  static SmartPagerCurrentQueue fromJson(Map<String, dynamic> json) {
    return SmartPagerCurrentQueue(
      id: json['id']?? '',
      email: json['client.email']?? '',
      restaurant: SmartPagerRestaurant.fromJson(json['restaurant']),
      waitingTime: json['client.waitingTime'],
      isCalled: json['client.isCalled']?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'restaurant': restaurant.toJson(),
      'waitingTime': waitingTime,
      'isCalled': isCalled,
    };
  }

  SmartPagerCurrentQueue copy() {
    return SmartPagerCurrentQueue(
      id: id,
      email: email,
      restaurant: restaurant,
      waitingTime: waitingTime,
      isCalled: isCalled,
    );
  }

}