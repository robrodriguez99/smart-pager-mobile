import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/config/cellules/login_form.dart';

import 'package:smart_pager/data/models/form_states.dart';
import 'package:smart_pager/data/models/user_model.dart';
import 'package:smart_pager/providers/user_provider.dart';
import '../auth_provider.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  build() => {};

  @override
  get state => super.state;

  void reset() {
    state = FormStates.initial.name;
  }

  Future<bool> login(
  ) async {
    state = FormStates.loading.name;
    try {
      final auth = ref.read(firebaseAuthProvider);
      SmartPagerUser user = await auth.signInWithGoogle();
      state = FormStates.success.name;
      ref.read(loggedUserProvider.notifier).set(user);
      return true;
    } catch (e) {
      state = FormStates.error.name;
      LoginFormKey.currentState!.validate();
      return false;
    }
  }

  void logout() {
    ref.read(firebaseAuthProvider).logout();
  }
}
