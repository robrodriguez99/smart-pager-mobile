import 'package:flutter/material.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'onboarding_screen.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.sizeOf(context).height * 0.5,
            padding: const EdgeInsets.all(10),
            child: Image.asset('${onBoardingList[index]['image']}'),
          ),
          CustomText(
            text: '${onBoardingList[index]['title']}',
            textAlign: TextAlign.start,
            color: SPColors.heading,
            height: 1.1,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(height: 20),
          CustomText(
            text: '${onBoardingList[index]['description']}',
            textAlign: TextAlign.start,
            fontFamily: 'outfit',
            color: SPColors.text,
            height: 1,
            maxLines: 6,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
