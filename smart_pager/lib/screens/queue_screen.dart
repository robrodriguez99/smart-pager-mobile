import 'package:flutter/material.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

/// Flutter code sample for [DropdownMenu].

const List<String> list = <String>['1', '2', '3', '4', '5',"6 o más"];

class QueueScreen extends StatelessWidget {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: SPColors.activeBlack,
                      size: 30,
                    ),
                  ),
                ],
              ),
              
                const SizedBox(height: 20),
                const Flexible(
                  child: CustomText(
                    text: 'El Bulli',
                    color: SPColors.heading,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                const Flexible(
                  child: CustomText(
                    text: 'Tiempo estimado de espera:',
                    color: SPColors.activeBlack,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Icon(
                      Icons.timer_sharp,
                      color: SPColors.activeBlack,
                      size: 16,

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
                        color: SPColors.darkGray,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              const DropdownMenuExample(),
              Expanded(child: Container()), 
              GradientButton(
              icon: Icons.access_time,
              text: "Anotarse en la cola",
                gradientColors: [SPColors.secondary, SPColors.secondary2],
                onPressed: () {
                    //
                  },
              ),
              SizedBox(height: 10),
              
            ]
          ),
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
