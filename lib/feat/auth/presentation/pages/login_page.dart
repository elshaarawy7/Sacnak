import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/auth/presentation/widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String pageId = "LoginPage" ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
    backgroundColor: AppColors.white ,
      body: LoginPageBody() ,  
    );
  }
}