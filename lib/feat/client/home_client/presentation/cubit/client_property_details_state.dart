import 'package:sacny/feat/client/home_client/domain/entity/client_property_details_entity.dart';

abstract class ClientPropertyDetailsState {}

class ClientPropertyDetailsInitial extends ClientPropertyDetailsState {}

class ClientPropertyDetailsLoading extends ClientPropertyDetailsState {}

class ClientPropertyDetailsLoaded extends ClientPropertyDetailsState {
  final ClientPropertyDetailsEntity property;

  ClientPropertyDetailsLoaded({required this.property});
}

class ClientPropertyDetailsError extends ClientPropertyDetailsState {
  final String errorMessage;

  ClientPropertyDetailsError({required this.errorMessage});
}
