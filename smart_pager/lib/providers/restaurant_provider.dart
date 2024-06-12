import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/data/models/restaurant_model.dart';

part 'restaurant_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentRestaurant extends _$CurrentRestaurant {
  @override
  SmartPagerRestaurant? build() => null;

  void set(SmartPagerRestaurant restaurant) => state = restaurant;
  

}