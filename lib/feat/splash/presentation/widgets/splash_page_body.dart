import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/constant/images_app.dart';
import 'package:sacny/core/helper/app_router.dart';
// قم باستيراد صفحة الـ Onboarding الخاصة بك هنا
// import 'package:sacny/features/onboarding/presentation/views/on_boarding_page.dart';

class SplashPageBody extends StatefulWidget {
  const SplashPageBody({super.key});

  @override
  State<SplashPageBody> createState() => _SplashPageBodyState();
}

class _SplashPageBodyState extends State<SplashPageBody> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  // دالة الانتظار والتنقل إلى صفحة الـ Onboarding
  void _navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      
      context.push(AppRouter.onBordingRoute); // استبدل 'onboardingRoute' بالمسار الفعلي لصفحة الـ Onboarding الخاصة بك

      // أو إذا كنت تستخدم GoRouter:
      // GoRouter.of(context).pushReplacement('/onBoarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutBack,
          tween: Tween(begin: 0.7, end: 1),
          builder: (context, scale, child) {
            return Opacity(
              opacity: scale.clamp(0, 1),
              child: Transform.scale(
                scale: scale,
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagesApp.LogoApp, // استبدل 'logo.png' بمسار الصورة الفعلي لشعار التطبيق ,
                width: 200,
                height: 200,
              ),
              const Gap(20),
              Text(
                'مرحبا بك في سكنك ',
                style: GoogleFonts.cairo(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}