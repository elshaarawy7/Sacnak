import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/admin/chats_admain/presentation/cubit/client_massege_state.dart';
import 'package:sacny/feat/admin/chats_admain/presentation/cubit/clients_massges_cubit.dart';

class MassegeClients extends StatelessWidget {
  const MassegeClients({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MassegeClientsCubit, MassegeClientsState>(
      listener: (context, state) {
        if (state is MassegeClientsFailure) {
          Fluttertoast.showToast(
            msg: state.errMessage,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            toastLength: Toast.LENGTH_SHORT,
          );
        }

        if (state is MassegeClientsSuccess) {
          Fluttertoast.showToast(
            msg: "تم تحميل الرسائل بنجاح",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      },
      builder: (context, state) {
        if (state is MassegeClientsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryGreen,
            ),
          );
        }

        if (state is MassegeClientsSuccess) {
          final clients = state.clients;

          if (clients.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد محادثات حالياً',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: clients.length,
            separatorBuilder: (context, index) => const Column(
              children: [
                Gap(10),
                Divider(color: Colors.grey, height: 1, thickness: 0.5),
                Gap(10),
              ],
            ),
            itemBuilder: (context, index) {
              final client = clients[index];
              return GestureDetector(
                onTap: () {
                  // TODO: التوجيه لصفحة الشات الخاصة بهذا المستأجر
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                          client.imageClient != null
                              ? NetworkImage(client.imageClient!)
                              : null,
                      child: client.imageClient == null
                          ? const Icon(Icons.person, size: 26)
                          : null,
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            client.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            client.message,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}