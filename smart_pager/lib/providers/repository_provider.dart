import 'package:riverpod_annotation/riverpod_annotation.dart';


import '../data/repositories/user_repository_impl.dart';

part 'repository_provider.g.dart';


@riverpod
UserRepositoryImpl userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl();
}
