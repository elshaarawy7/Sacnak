import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/onbourding/presentation/widgets/onbourding_page_body.dart';

class OnBordingPageone extends StatelessWidget {
  const OnBordingPageone({super.key}); 
  static const String routeName = '/onBordingPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: const OnboardingWelcomeScreen(),
    );
  }
}