import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/data/models/restaurant_model.dart';
import 'package:smart_pager/data/models/user_model.dart';
import 'package:smart_pager/providers/auth_provider.dart';
import 'package:smart_pager/providers/repository_provider.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class LoggedUser extends _$LoggedUser {
  @override
  SmartPagerUser? build() => null;

  Future<void> refresh() async {
    final user = await ref.read(firebaseAuthProvider).currentUser();
    if (user != null) {
      final loggedUser = await ref
          .read(userRepositoryProvider)
          .getUsersById(user.uid);
      state = loggedUser;
    }
  }

  void set(SmartPagerUser user) => state = user;

  void enqueueRestaurant(String restaurantSlug, String description, int commensalsAmount) {
    state!.currentRestaurantSlug = restaurantSlug;
    state!.description = description;
    state!.commensalsAmount = commensalsAmount;
    state = state!.copy();
  }

  void updateUser(Map<String, dynamic> newFields) {
    state!.phoneNumber = newFields['phoneNumber'];
    state!.name = newFields['name'];
    state = state!.copy();
  }
}
