import 'package:flutter/material.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/add_drage_page_body.dart';
import 'package:sacny/feat/admin/chats_admain/presentation/widgets/add_drage_page_body.dart';

class AdminChatsPage extends StatelessWidget {
  const AdminChatsPage({super.key});

  static const String routeName = "AdminChatsPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminChatsPageBody(),
    );
  }
}