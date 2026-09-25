import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/feat/client/home_client/domain/entity/client_property_details_entity.dart';
import 'package:sacny/feat/client/home_client/domain/usecase/get_client_property_details_usecase.dart';
import 'package:sacny/feat/client/home_client/presentation/cubit/client_property_details_state.dart';

class ClientPropertyDetailsCubit extends Cubit<ClientPropertyDetailsState> {
  final GetClientPropertyDetailsUseCase getClientPropertyDetailsUseCase;

  ClientPropertyDetailsCubit({required this.getClientPropertyDetailsUseCase})
      : super(ClientPropertyDetailsInitial()); 


  Future<void> fetchPropertyDetails(String propertyId) async {
    emit(ClientPropertyDetailsLoading());
    final result = await getClientPropertyDetailsUseCase(propertyId);
    result.fold(
      (failure) => emit(ClientPropertyDetailsError(errorMessage: failure.message)),
      (property) => emit(ClientPropertyDetailsLoaded(property: property)),
    );
  }  


  Future<void> searchForProperty(String search) async {
    emit(ClientPropertyDetailsLoading());
    final result = await getClientPropertyDetailsUseCase.searchForProperty(search);
    result.fold(
      (failure) => emit(ClientPropertyDetailsError(errorMessage: failure.message)),
      (property) => emit(ClientPropertyDetailsLoaded(property: property as ClientPropertyDetailsEntity)),  
    );
  } 


}
