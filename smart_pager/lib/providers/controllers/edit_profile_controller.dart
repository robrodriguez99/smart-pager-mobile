import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/data/models/form_states.dart';

import 'package:smart_pager/data/models/user_model.dart';
import 'package:smart_pager/providers/auth_provider.dart';

import 'package:smart_pager/providers/repository_provider.dart';
import 'package:smart_pager/providers/user_provider.dart';
import 'package:smart_pager/screens/profile_edit_screen.dart';

part 'edit_profile_controller.g.dart';

@riverpod
class EditProfileController extends _$EditProfileController {
  @override
  build() => {};

  @override
  get state => super.state;

  void reset() {
    state = FormStates.initial.name;
  }

  Future<void> editProfile(String uid, String? name, String? phoneNumber) async {
    state = FormStates.loading.name;
    try {
      final newFields = {
        'name': name,
        'phoneNumber': phoneNumber,
      };

      await ref.read(userRepositoryProvider).updateUser(uid, newFields);
      ref.read(loggedUserProvider.notifier).updateUser(newFields);
      state = FormStates.success.name;
    
    } catch (e) {
      state = FormStates.error.name;
      EditProfileFormKey.currentState!.validate();
    }


  }
}
