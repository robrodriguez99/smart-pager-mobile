import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/data/models/restaurant_model.dart';
import 'package:smart_pager/providers/api_provider.dart';
import 'package:smart_pager/providers/restaurant_provider.dart';
import 'package:smart_pager/providers/user_provider.dart';

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

  Future<void> loadRestaurants({int page = 0, int pageSize = 10}) async {
    try {
      final api = ref.read(apiServiceProvider);
      final newRestaurants =
          await api.getRestaurants(page: page, pageSize: pageSize);

      // Filter out duplicates based on restaurant slug
      final updatedRestaurants =
          List<SmartPagerRestaurant>.from(state.value ?? [])
            ..addAll(newRestaurants.where((newRestaurant) => !state.value!.any(
                (existingRestaurant) =>
                    existingRestaurant.slug == newRestaurant.slug)));

      state = AsyncValue.data(updatedRestaurants);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> addToQueue(
    String restaurantSlug,
    String description,
    int commensalsAmount,
  ) async {
    try {
      final api = ref.read(apiServiceProvider);
      SmartPagerRestaurant? restaurant = ref.watch(currentRestaurantProvider);
      restaurant ??= await getRestaurant(restaurantSlug);
      final futureUser = ref.watch(loggedUserProvider);
      await api.addToQueue(
          restaurantSlug, futureUser!, description, commensalsAmount);
    } catch (e) {
      // handle error
    }
  }

  Future<List<SmartPagerRestaurant>> getRestaurants(
      {String? search,
      String? category,
      int page = 0,
      int pageSize = 10}) async {
    try {
      final api = ref.read(apiServiceProvider);
      List<SmartPagerRestaurant> restaurants = await api.getRestaurants(
          search: search, category: category, page: page, pageSize: pageSize);
      return restaurants;
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }

  Future<SmartPagerRestaurant> getRestaurant(String slug) async {
    try {
      final api = ref.read(apiServiceProvider);
      SmartPagerRestaurant restaurant = await api.getRestaurant(slug);
      ref.read(currentRestaurantProvider.notifier).set(restaurant);
      return restaurant;
    } catch (e) {
      return SmartPagerRestaurant(
        id: "Error",
        type: "Error",
        avgTimePerTable: "Error",
        isPromoted: false,
        name: "Error",
        slug: "Error",
        email: "Error",
      );
    }
  }

  Future<List<String>> getRestaurantCategories() async {
    try {
      final api = ref.read(apiServiceProvider);
      List<String> categories = await api.getRestaurantCategories();
      return categories;
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }
}
