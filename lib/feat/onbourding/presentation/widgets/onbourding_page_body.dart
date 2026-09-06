import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sacny/core/helper/app_router.dart';
import 'package:sacny/core/widgets/custom_batton.dart';
import 'package:sacny/core/widgets/logo_widgets.dart';
import 'package:sacny/feat/onbourding/presentation/widgets/university_info_widget.dart';
import 'package:sacny/feat/onbourding/presentation/widgets/welcome_text_widget.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({super.key, this.onGetStarted});

  final VoidCallback? onGetStarted;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const Gap(50),
              const LogoWidgets(),
              const Gap(20),
              const WelcomeTextWidget(),
              const Gap(20),
              const UniversityInfoWidget(),
              const Gap(80),
              CustomBatton(
                ontap: () {
                  context.push(AppRouter.onBordingPageTow);
                },
                text: "التالي",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
