import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/data/repositories/notification_repository_impl.dart';


import '../data/repositories/user_repository_impl.dart';

part 'repository_provider.g.dart';


@riverpod
UserRepositoryImpl userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl();
}

@riverpod
NotificationRepositoryImpl notificationRepository(NotificationRepositoryRef ref) {
  
  return NotificationRepositoryImpl();
}