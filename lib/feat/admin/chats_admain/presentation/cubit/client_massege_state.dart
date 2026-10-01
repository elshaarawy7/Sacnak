import 'package:equatable/equatable.dart';
import 'package:sacny/feat/admin/chats_admain/domain/entity/massege_clients_entity.dart';

abstract class MassegeClientsState extends Equatable {
  const MassegeClientsState();

  @override
  List<Object?> get props => [];
}

class MassegeClientsInitial extends MassegeClientsState {}

class MassegeClientsLoading extends MassegeClientsState {}

class MassegeClientsSuccess extends MassegeClientsState {
  final List<MassegeClientsEntity> clients;

  const MassegeClientsSuccess(this.clients);

  @override
  List<Object?> get props => [clients];
}

class MassegeClientsFailure extends MassegeClientsState {
  final String errMessage;

  const MassegeClientsFailure(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}