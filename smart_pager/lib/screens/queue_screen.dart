import 'package:flutter/material.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:go_router/go_router.dart';

/// Flutter code sample for [DropdownMenu].

const List<String> list = <String>['1', '2', '3', '4', '5', "6 o más"];

class QueueScreen extends StatelessWidget {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => GoRouter.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: SPColors.activeBlack,
              size: 30,
            ),
          ),
          title: const CustomText(
            text: 'El Bulli',
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              Center(
                // Wrap the Image.asset with Center widget
                child: Image.asset(
                  'assets/images/black_logo.png', // Path to your restaurant image asset
                  width: 200, // Adjust size as needed
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 15),
              const Flexible(
                child: CustomText(
                  text: 'Tiempo estimado de espera:',
                  color: SPColors.activeBlack,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    color: SPColors.activeBlack,
                    size: 18,
                  ),
                  Flexible(
                    child: CustomText(
                      text: ' 20 minutos',
                      color: SPColors.darkGray,
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              const Flexible(
                child: CustomText(
                  text: 'Indicá cuantos van a ser',
                  color: SPColors.activeBlack,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const DropdownMenuExample(),
              Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20), // Add left and right margin here
                child: GradientButton(
                  icon: Icons.wb_twilight,
                  text: "Anotarse en la cola",
                  gradientColors: const [
                    SPColors.secondary,
                    SPColors.secondary
                  ],
                  onPressed: () {
                    //
                  },
                ),
              ),
              const SizedBox(height: 10),
            ]),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}