import 'package:smart_pager/data/models/generic_model.dart';
import 'package:smart_pager/data/models/restaurant_model.dart';

class SmartPagerCurrentQueue extends GenericModel<SmartPagerCurrentQueue> {
  final String email;
  SmartPagerRestaurant restaurant;
  int position;
  int waitingTime;
  // int? commensalsAmount;


  SmartPagerCurrentQueue({
    required super.id,
    required this.email,
    required this.restaurant,
    required this.position,
    required this.waitingTime,
  });

  Object? get state => null;

  @override
  static SmartPagerCurrentQueue fromJson(Map<String, dynamic> json) {
    return SmartPagerCurrentQueue(
      id: json['id']?? '',
      email: json['client.email']?? '',
      restaurant: SmartPagerRestaurant.fromJson(json['restaurant']),
      position: json['positionInQueue'],
      waitingTime: json['client.waitingTime'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'restaurant': restaurant.toJson(),
      'position': position,
      'waitingTime': waitingTime,
    };
  }

  SmartPagerCurrentQueue copy() {
    return SmartPagerCurrentQueue(
      id: id,
      email: email,
      restaurant: restaurant,
      position: position,
      waitingTime: waitingTime,
    );
  }

}