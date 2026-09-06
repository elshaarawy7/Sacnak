import 'package:flutter/material.dart';
import 'package:sacny/feat/onbourding/presentation/widgets/onbourding_page_tow_body.dart';

class OnbourdingPageTow extends StatelessWidget {
  const OnbourdingPageTow({super.key}); 

  static const String pageId = "OnbourdingPageTow" ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: OnbourdingPageTowBody(),
    );
  }
}