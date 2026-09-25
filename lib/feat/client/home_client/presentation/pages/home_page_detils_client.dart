import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/core/server/geti.dart';
import 'package:sacny/feat/client/home_client/presentation/cubit/client_property_details_cubit.dart';
import 'package:sacny/feat/client/home_client/presentation/widgets/home_page_client_detils_body.dart';

class HomePageDetilsClient extends StatelessWidget {
  final String propertyId;

  const HomePageDetilsClient({
    super.key,
    required this.propertyId,
  });

  static const String routerName = "/homePageDetilsClient";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getit<ClientPropertyDetailsCubit>()..fetchPropertyDetails(propertyId),
      child: HomePageClientDetilsBody(propertyId: propertyId),
    );
  }
}
