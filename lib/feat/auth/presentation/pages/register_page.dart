import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/server/geti.dart';
import 'package:sacny/feat/auth/presentation/manager/gooole/google_cubit.dart';
import 'package:sacny/feat/auth/presentation/manager/regester/regester_cubit.dart';
import 'package:sacny/feat/auth/presentation/widgets/regester_page_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const String registerPageRoute = "RegisterPage";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getit<RegesterCubit>()),
        BlocProvider(create: (context) => getit<GoogleCubit>()),
      ],
      child: const Scaffold(
        backgroundColor: AppColors.lightBg,
        body: RegisterPageBody(),
      ),
    );
  }
}
