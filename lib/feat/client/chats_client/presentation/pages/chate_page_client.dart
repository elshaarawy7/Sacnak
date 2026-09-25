import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/client/chats_client/presentation/widgets/chate_page_client_body.dart';

class ChatePageClient extends StatelessWidget {
  const ChatePageClient({super.key}); 

  static const String routerName = "/chatPageClient" ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg, 
      body: ChatePageClientBody(),
    );
  }
}