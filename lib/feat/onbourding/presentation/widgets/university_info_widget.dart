import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';

class UniversityInfoWidget extends StatelessWidget {
  const UniversityInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.school,
          color: AppColors.primaryGreen,
          size: 30,
        ),
        const Gap(10),
        Text(
          "Serving Top Egyptian Universities",
          style: TextStyle(
            color: AppColors.primaryGreen,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
