import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/admin/chats_admain/presentation/widgets/massege_clients.dart';

class ListViewMassegsClient extends StatelessWidget {
  const ListViewMassegsClient({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) { 

        return Padding(
          padding: const EdgeInsets.symmetric( vertical: 5),
          child: MassegeClients(),
        );
      },
    );
  }
}