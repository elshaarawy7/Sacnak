import 'package:flutter/material.dart';
import 'package:sacny/feat/admin/chats_admain/presentation/widgets/admain_chate_page_body.dart';

class AdminChatsPage extends StatelessWidget {
  const AdminChatsPage({super.key});

  static const String routeName = "AdminChatsPage";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AdminChatsPageBody());
  }
}
