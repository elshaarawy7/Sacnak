import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/feat/admin/chats_admain/data/repo/masseges_clients_repo.dart';
import 'package:sacny/feat/admin/chats_admain/presentation/cubit/client_massege_state.dart';

class MassegeClientsCubit extends Cubit<MassegeClientsState> {
  final RepoMassegeClients repoMassegeClients;

  MassegeClientsCubit(this.repoMassegeClients) : super(MassegeClientsInitial()); 

  static MassegeClientsCubit get(BuildContext context) => BlocProvider.of<MassegeClientsCubit>(context);

  Future<void> fetchMassegeClients() async {
    emit(MassegeClientsLoading());

    final result = await repoMassegeClients.getMassegeClients();

    result.fold(
      (failure) => emit(MassegeClientsFailure(failure.message)),
      (clientsList) => emit(MassegeClientsSuccess(clientsList)),
    );
  }
}