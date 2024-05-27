import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/providers/controllers/restaurant_controller.dart';
import 'package:smart_pager/providers/user_provider.dart';

/// Flutter code sample for [DropdownMenu].

const List<String> list = <String>['1', '2', '3', '4', '5', "6 o más"];

class QueueScreen extends ConsumerStatefulWidget {
  const QueueScreen({super.key});

  @override
  ConsumerState<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends ConsumerState<QueueScreen> {
  String dropdownValue = list.first; // Nuevo estado

  @override
  Widget build(BuildContext context) {
    final futureUser = ref.watch(loggedUserProvider);

    return Scaffold(
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
          text: 'el club de la mila',
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                text: ' 45 minutos',
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
        // Add DropdownMenuExample widget here
        DropdownMenuExample(
          onSelected: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
        ),

        Expanded(child: Container()),
        Container(
          margin: const EdgeInsets.symmetric(
              horizontal: 20), // Add left and right margin here
          child: GradientButton(
            icon: Icons.wb_twilight,
            text: "Anotarse en la cola",
            gradientColors: const [SPColors.secondary, SPColors.secondary],
            onPressed: () async {
              await ref
                  .read(restaurantControllerProvider.notifier)
                  .addToQueue(
                    'g8-hci-1', //TODO: Add restaurant slug here
                    futureUser!,
                    'description', //TODO: Add description here
                    int.parse(dropdownValue),
                  )
                  .then((value) => {
                        GoRouter.of(context).goNamed('current-queue')
                      }); // Add commensals amount here
            },
          ),
        ),
        const SizedBox(height: 30),
      ]),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  final ValueChanged<String?>? onSelected;

  const DropdownMenuExample({this.onSelected, super.key});

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
        setState(() {
          dropdownValue = value!;
        });
        if (widget.onSelected != null) {
          widget.onSelected!(dropdownValue);
        }
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
