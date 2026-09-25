import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/client/profile_client/presentation/widgets/profile_page_client_imple.dart';

class ProfilePageClient extends StatelessWidget {
  const ProfilePageClient({super.key}); 

   static const String routerName = '/profilePageClient' ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white , 
      body: ProfilePageClientBody(),
    );
  }
}