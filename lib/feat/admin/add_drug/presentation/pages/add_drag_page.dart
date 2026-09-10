import 'package:flutter/material.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/add_drage_page_body.dart';

class AddDragPage extends StatelessWidget {
  const AddDragPage({super.key});

  static const String routeName = "AddDragPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddDragePageBody(),
    );
  }
}