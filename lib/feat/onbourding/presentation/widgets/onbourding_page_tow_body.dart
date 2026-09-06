import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sacny/core/helper/app_router.dart';
import 'package:sacny/core/widgets/custom_batton.dart';
import 'package:sacny/feat/onbourding/presentation/widgets/onboarding_image_card.dart';

class OnbourdingPageTowBody extends StatelessWidget {
  const OnbourdingPageTowBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const Gap(80),
            const OnboardingImageCard(),
            const Gap(100),
            CustomBatton(
              ontap: () {
                context.push(AppRouter.LoginPageRote);
              },
              text: "ابداء الان ",
            ),
          ],
        ),
      ),
    );
  }
}
