import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/core/server/geti.dart';
import 'package:sacny/feat/admin/home_admain/presentation/cubit/cart_home_admin_cubit.dart';
import 'package:sacny/feat/client/home_client/presentation/widgets/home_page_client_body.dart';

class HomePageClient extends StatelessWidget {
  const HomePageClient({super.key}); 

  static const String routerName = "/homePageClient";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => getit<CartHomeAdminCubit>()..getProperties(),
        child: const HomePageClientBody(),
      ),
    );
  }
}