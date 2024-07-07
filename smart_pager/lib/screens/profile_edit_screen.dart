import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_pager/providers/controllers/edit_profile_controller.dart';
import 'package:smart_pager/providers/edit_profile_provider.dart';
import 'package:smart_pager/providers/user_provider.dart';

final GlobalKey<FormState> EditProfileFormKey = GlobalKey<FormState>();

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends ConsumerState<ProfileEditScreen> {
  String name = "";
  String phoneNumber = "";
  DateTime? dateOfBirth; // Variable to store date of birth

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController =
      TextEditingController(); // Controller for date of birth

  @override
  void initState() {
    super.initState();
    nameController.text = "";
    phoneNumberController.text = "";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final futureUser = ref.watch(loggedUserProvider);
    nameController.text = futureUser?.name ?? "";
    phoneNumberController.text = futureUser?.phoneNumber ?? "";
    phoneNumber = futureUser?.phoneNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        title: const CustomText(
          text: 'Editar perfil',
          color: SPColors.heading,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: EditProfileFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre Completo*',
                  labelStyle: TextStyle(fontSize: 18, color: SPColors.darkGray),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(fontSize: 18),
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa tu nombre';
                  }
                  if (value.length > 50) {
                    return 'El nombre debe tener máximo 50 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              phoneNumber = number.phoneNumber!;
                            },
                            selectorTextStyle: const TextStyle(
                                color: SPColors.darkGray, fontSize: 18),
                            initialValue: PhoneNumber(
                              phoneNumber: phoneNumber,
                              isoCode: 'AR',
                            ),
                            countries: const ['AR'],
                            inputDecoration: const InputDecoration(
                              labelText: 'Número de teléfono',
                              labelStyle: TextStyle(
                                  fontSize: 18, color: SPColors.darkGray),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(fontSize: 18),
                            ),
                            maxLength: 12,
                            formatInput: true,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            validator: (value) {
                              if (value!.isNotEmpty && value.length != 12) {
                                return 'El número debe tener 10 digitos';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Formato del número de teléfono: +(54) 11 2345-6789.",
                            style: TextStyle(
                                color: SPColors.darkGray, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15.0), // Border radius here
                    ),
                    child: ElevatedButton(
                      onPressed: () => _onPressed(context, ref),
                      // onPressed: () {
                      //   if (EditProfileFormKey.currentState!.validate()) {
                      //     setState(() {
                      //       name = nameController.text;
                      //       phoneNumber = phoneNumberController.text;
                      //     });
                      //     Map<String, dynamic> newFields = {
                      //       'name': name,
                      //       'phoneNumber': phoneNumber
                      //     };
                      //     ref.read(loggedUserProvider.notifier).updateUser(
                      //         newFields);
                      //     Navigator.pop(context);
                      //   }
                      // },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: SPColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Same border radius here
                        ),
                      ),
                      child: const Text(
                        "Guardar cambios",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  _onPressed(BuildContext context, WidgetRef ref) {
    if (EditProfileFormKey.currentState!.validate()) {
      final uid = ref.read(loggedUserProvider)!.id;
      final namePath = nameController.text;

      ref.read(editProfileValidatorProvider.notifier).loading();

      ref
          .read(editProfileControllerProvider.notifier)
          .editProfile(uid, namePath, phoneNumber);

      if (context.mounted) {
        GoRouter.of(context).pop(true);
      }
    }
  }
}
