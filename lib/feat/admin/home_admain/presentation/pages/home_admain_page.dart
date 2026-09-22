import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/core/server/geti.dart';
import 'package:sacny/feat/admin/home_admain/presentation/widgets/home_admin_page_body.dart';
import 'package:sacny/feat/admin/home_admain/presentation/cubit/cart_home_admin_cubit.dart';

class HomeAdmainPage extends StatelessWidget {
  const HomeAdmainPage({super.key});

  static const String routeName = "HomeAdmainPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider( 
        create: (context) => getit<CartHomeAdminCubit>()..getProperties(),
        child: const HomeAdminPageBody(),
      ),
    );
  }
}
