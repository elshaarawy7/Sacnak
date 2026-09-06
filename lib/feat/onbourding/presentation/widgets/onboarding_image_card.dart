import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/constant/images_app.dart';
import 'package:sacny/feat/onbourding/presentation/widgets/onboarding_badge.dart';

class OnboardingImageCard extends StatelessWidget {
  const OnboardingImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(ImagesApp.SplashImage),
          fit: BoxFit.fill,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Gap(20),
            Align(
              alignment: Alignment.topLeft,
              child: OnboardingBadge(
                width: 230,
                text: "استكشف سكنك الجامعي المثالي بسهولة ",
                backgroundColor: AppColors.primaryGreen,
                textColor: Colors.white,
              ),
            ),
            Gap(150),
            Align(
              alignment: Alignment.bottomRight,
              child: OnboardingBadge(
                width: 150,
                text: "وفر وقت الزحمه يوميا ",
                backgroundColor: AppColors.white,
                textColor: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
