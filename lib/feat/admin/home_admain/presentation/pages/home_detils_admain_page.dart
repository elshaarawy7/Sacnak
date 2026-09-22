import 'package:flutter/material.dart';
import 'package:sacny/feat/admin/home_admain/domain/entity/entuty_cart_home_admin_model.dart';
import 'package:sacny/feat/admin/home_admain/presentation/widgets/home_detils_admain_page.dart';

class HomeDetilsAdmainPage extends StatelessWidget {
  const HomeDetilsAdmainPage({super.key, required this.property});

  final EntutyCartHomeAdminModel property;

  static const String routeName = "homeDetilsPage";

  @override
  Widget build(BuildContext context) {
    return HomeDetilsAdmainPageBody(property: property);
  }
}
