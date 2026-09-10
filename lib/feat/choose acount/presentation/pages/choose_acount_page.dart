import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/choose%20acount/presentation/widgets/choose_acount_page_body.dart';

class ChooseAcountPage extends StatelessWidget {
  const ChooseAcountPage({super.key}); 

  static const String routeName = "ChooseAcountPage";  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg ,
      body: ChooseAcountPageBody() ,
    );
  }
}