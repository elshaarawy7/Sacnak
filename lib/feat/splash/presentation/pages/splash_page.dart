import 'package:flutter/material.dart';
import 'package:sacny/feat/splash/presentation/widgets/splash_page_body.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key}); 

  static const String routeName = '/splashPage';

  @override
  Widget build(BuildContext context) {
    return SplashPageBody();
  }
}