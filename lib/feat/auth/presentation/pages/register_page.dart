import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/auth/presentation/widgets/login_page_body.dart';
import 'package:sacny/feat/auth/presentation/widgets/regester_page_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const String registerPageRoute = "RegisterPage";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.lightBg,
      body: RegisterPageBody(),
    );
  }
}
