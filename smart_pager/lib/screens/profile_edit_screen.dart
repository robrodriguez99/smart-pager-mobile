import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditScreen> {
  String name = "Federico";
  String surname = "Rojas";
  String phoneNumber = "541156019614";
  DateTime? dateOfBirth; // Variable to store date of birth

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController =
      TextEditingController(); // Controller for date of birth

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = name;
    surnameController.text = surname;
    phoneNumberController.text = phoneNumber;
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
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre(s)*',
                  labelStyle: TextStyle(fontSize: 18, color: SPColors.darkGray),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(fontSize: 18),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa tu nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: surnameController,
                decoration: const InputDecoration(
                  labelText: 'Apellido(s)*',
                  labelStyle: TextStyle(fontSize: 18, color: SPColors.darkGray),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(fontSize: 18),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa tu apellido';
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
                      child: InternationalPhoneNumberInput(
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
                          labelText: 'Número de teléfono *',
                          labelStyle:
                              TextStyle(fontSize: 18, color: SPColors.darkGray),
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(fontSize: 18),
                        ),
                        maxLength: 12,
                        formatInput: true,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu número de teléfono';
                          }
                          if (value.length != 12) {
                            return 'El número debe tener 12 digitos';
                          }
                          return null;
                        },
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
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          name = nameController.text;
                          surname = surnameController.text;
                          phoneNumber = phoneNumberController.text;
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: SPColors.primary,
                    ),
                    child: const Text(
                      "Guardar cambios",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
}
