import 'package:smart_pager/data/models/restaurant_model.dart';
import 'package:smart_pager/data/models/user_model.dart';
import 'package:smart_pager/data/repositories/repository.dart';
import 'package:smart_pager/exceptions/not_found_exception.dart';


class UserRepositoryImpl extends Repository<SmartPagerUser> {
  UserRepositoryImpl() : super('Users');

  Future<SmartPagerUser> createUser(SmartPagerUser user) async {
    return await create(user);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> update) async {
    final Map<String, dynamic> updateUser = {};
    print("update: $update");
    if (update.containsKey('phoneNumber')) {
      updateUser["phoneNumber"] = update["phoneNumber"];
    }
    if (update.containsKey("name")) {
      updateUser["name"] = update["name"];
    }

    await collection.doc(uid).update(updateUser);
  }

  Future<void> setUserCurrentRestaurantQueue(
      String uid, String restaurantSlug, String description, int commensalsAmount) async {
    final Map<String, dynamic> update = {};
    update["currentRestaurantSlug"] = restaurantSlug;
    update["description"] = description;
    update["commensalsAmount"] = commensalsAmount;

    print("que tul");

    setUserQueue(uid, true);
    await collection.doc(uid).update(update);
  }

  Future<void> setUserQueue(String uid, bool isInQueue) async {
    final Map<String, dynamic> update = {
      "isInQueue": isInQueue,
    };
    await collection.doc(uid).update(update);

  }
  

  // @throws NotFoundException
  Future<SmartPagerUser> getUserByEmail(String email) async {
    try {
      final querySnapshot =
          await collection.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        final user = itemFromJson(
            querySnapshot.docs.first.id, querySnapshot.docs.first.data());
        return user;
      } else {
        throw NotFoundException("User with email $email not found");
      }
    } catch (e) {
      print("error $e");
      // Rethrow the exception or handle it as needed.
      throw e;
    }
  }

  Future<SmartPagerUser> getUsersById(String id) async {
    try {
      final querySnapshot = await collection.doc(id).get();
      if (querySnapshot.exists) {
        final user = itemFromJson(id, querySnapshot.data()!);
        return user;
      } else {
        throw NotFoundException("User with id $id not found");
      }
    } catch (e) {
      print(e);
      // Rethrow the exception or handle it as needed.
      throw e;
    }
  }

  @override
  SmartPagerUser itemFromJson(String id, Map<String, dynamic> json) {
    json["id"] = id;
    return SmartPagerUser.fromJson(json);
  }
}
