import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/providers/controllers/login_controller.dart';
import 'package:smart_pager/providers/login_provider.dart';

final LoginFormKey = GlobalKey<FormBuilderState>();

class LoginForm extends ConsumerWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = ref.watch(loginControllerProvider.notifier);

    onChangeFocus (field, value) {
      // ref.read(loginValidatorProvider.notifier).set(field, value.isNotEmpty);
    }


    return FormBuilder(
      key: LoginFormKey,
      enabled: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FormBuilderTextField(
            name: 'email',
            onChanged: (value) => onChangeFocus('email', value),
            decoration:const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Correo electrónico',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            // validator: FormBuilderValidators.compose([
            //   FormBuilderValidators.required(context),
            //   FormBuilderValidators.email(context),
            // ]),
          ),
          const SizedBox(height: 20),
          FormBuilderTextField(
            name: 'password',
            onChanged: (value) => onChangeFocus('password', value),
            decoration:const  InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Contraseña',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            // validator: FormBuilderValidators.compose([
            //   FormBuilderValidators.required(context),
            //   FormBuilderValidators.minLength(context, 6),
            // ]),
          ),
          
        ],
      ),
    );
  }
}
