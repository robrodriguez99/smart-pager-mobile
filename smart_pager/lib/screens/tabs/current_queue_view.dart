import 'package:flutter/material.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class CurrentQueueView extends StatelessWidget {
  const CurrentQueueView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [   
                SizedBox(height: 10),
                Flexible(
                  child: CustomText(
                    text: 'Actualmente estas haciendo fila en:',
                    color: SPColors.heading,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 20),
                Flexible(
                  child: CustomText(
                    text: 'El Bulli',
                    color: SPColors.heading,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                  child: CustomText(
                    text: 'Tiempo estimado de espera:',
                    color: SPColors.activeBlack,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
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
                SizedBox(height: 10),
                Flexible(
                  child: CustomText(
                    text: 'Te vamos a avisar cuando tu mesa este lista',
                    color: SPColors.darkGray,
                    fontSize: 20,
                    overflow: TextOverflow.visible,
                  ),
                ),

                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                CustomText(
                  text: 'Si cambias de opinión podés cancelar la fila en cualquier momento',
                  color: SPColors.darkGray,
                  fontSize: 15,
                  overflow: TextOverflow.visible,
                ),
                GradientButton(
                  text: 'Cancelar turno',
                  gradientColors: [SPColors.red, SPColors.orange],
                  
                ),
                   
              ],
            ),
          ],
        ),
      ),
    );
  }
}
