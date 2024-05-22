import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/data/models/form_states.dart';
import 'package:smart_pager/data/models/restaurant_model.dart';
import 'package:smart_pager/data/models/user_model.dart';
import 'package:smart_pager/providers/api_provider.dart';


part 'restaurant_controller.g.dart';

@riverpod
class RestaurantController extends _$RestaurantController {
  @override
  Future<List<SmartPagerRestaurant>> build() async {
    final restaurants = await getRestaurants();
    return restaurants;
  }

  @override
  get state => super.state;

  // Future<void> getRestaurants() async {
  //   state = FormStates.loading.name;
  //   try {
  //     // final api = ref.read(apiServiceProvider);
  //     // List<Restaurant> restaurants = await api.getRestaurants();
  //     state = FormStates.success.name;
  //     // ref.read(restaurantsProvider.notifier).set(restaurants);
  //   } catch (e) {
  //     state = FormStates.error.name;
  //   }
  // }

  Future<void> getHello() async {
    // state = FormStates.loading.name as AsyncValue<List<SmartPagerRestaurant>>;
    try {
      final api = ref.read(apiServiceProvider);
      await api.getHello();
      // state = FormStates.success.name as AsyncValue<List<SmartPagerRestaurant>>;
    } catch (e) {
      // state = FormStates.error.name as AsyncValue<List<SmartPagerRestaurant>>;
    }
  }

  Future<void> addToQueue(
    String restaurantSlug,
    SmartPagerUser user,
    String description,
    int commensalsAmount,
  ) async {
    // state = FormStates.loading.name as AsyncValue<List<SmartPagerRestaurant>>;
    try {
      final api = ref.read(apiServiceProvider);
      await api.addToQueue(restaurantSlug, user, description, commensalsAmount);
      // state = FormStates.success.name as AsyncValue<List<SmartPagerRestaurant>>;
    } catch (e) {
      // state = FormStates.error.name as AsyncValue<List<SmartPagerRestaurant>>;
    }
  }

    Future<List<SmartPagerRestaurant>> getRestaurants(
    {String? search, int page=0, int pageSize = 10}
  ) async {
    // state = FormStates.loading.name as AsyncValue<List<SmartPagerRestaurant>>;
    try {
      final api = ref.read(apiServiceProvider);
      List<SmartPagerRestaurant> restaurants = await api.getRestaurants(search: search, page: page, pageSize: pageSize);
      print("restaurants: $restaurants");
      // state = FormStates.success.name as AsyncValue<List<SmartPagerRestaurant>>;
      return restaurants;
    } catch (e, s) {
      // state = FormStates.error.name as AsyncValue<List<SmartPagerRestaurant>>;
      print(e);
      print(s);
      return [];
    }
  }




}
