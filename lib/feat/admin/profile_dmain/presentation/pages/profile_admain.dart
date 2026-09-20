import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/core/server/geti.dart';
import 'package:sacny/feat/admin/profile_dmain/presentation/cubit/profile_admain_cubit.dart';
import 'package:sacny/feat/admin/profile_dmain/presentation/widgets/profile_admin_page_body.dart';

class ProfileAdmain extends StatelessWidget {
  const ProfileAdmain({super.key});

  static const String routeName = "ProfileAdmain";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit<ProfileAdminCubit>(),
      child: const Scaffold(
        backgroundColor: Colors.white , 
        body: SafeArea(
          child: ProfileAdminPageBody(),
        ),
      ),
    );
  }
}