import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'مرحبا بك في ساكني ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryGreen,
          ),
        ),
        const Gap(20),
        const Text(
          " سكن طلابي مريح وقريب من جامعتك",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
