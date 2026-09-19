import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/core/server/geti.dart';
import 'package:sacny/feat/admin/add_drug/presentation/cubit/propetry_cubit.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/add_drage_page_body.dart';

class AddDragPage extends StatelessWidget {
  const AddDragPage({super.key});

  static const String routeName = "AddDragPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getit<PropertyCubit>(),
        child: const AddDragePageBody(),
      ),
    );
  }
}