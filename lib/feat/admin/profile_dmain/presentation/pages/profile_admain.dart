import 'package:flutter/material.dart';
import 'package:sacny/feat/admin/profile_dmain/presentation/widgets/profile_admin_page_body.dart';

class ProfileAdmain extends StatelessWidget {
  const ProfileAdmain({super.key});

  static const String routeName = "ProfileAdmain";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.
      body: SafeArea(
        child: ProfileAdminPageBody(),
      ),
    );
  }
}