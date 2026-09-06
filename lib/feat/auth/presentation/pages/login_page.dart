import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/auth/presentation/widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.initialTab = 0});

  static const String loginPageRote = "LoginPage";

  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: LoginPageBody(initialTab: initialTab),
    );
  }
}