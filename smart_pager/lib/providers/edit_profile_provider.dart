import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileValidatorProvider =
    StateNotifierProvider<EditProfileValidator, bool>(
        (ref) => EditProfileValidator(true));

class EditProfileValidator extends StateNotifier<bool> {
  EditProfileValidator(super.state);

  final Map<String, bool> _fields = {
    'name': false,
    'phoneNumber': false
  };

  void loading() {
    state = false;
  }

  void reset() {
    state = true;
  }

  void set(String field, bool value) {
    _fields[field] = value;
    state = _fields.values.every((element) => element);
  }
}
