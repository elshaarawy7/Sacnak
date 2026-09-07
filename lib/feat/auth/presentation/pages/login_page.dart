import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/server/geti.dart';
import 'package:sacny/feat/auth/presentation/widgets/login_page_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/feat/auth/presentation/manager/login/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.initialTab = 0});

  static const String loginPageRote = "LoginPage";

  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit<LoginCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        body: LoginPageBody(initialTab: initialTab),
      ),
    );
  }
}
