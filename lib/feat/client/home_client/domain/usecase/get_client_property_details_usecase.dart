import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/client/home_client/domain/entity/client_property_details_entity.dart';
import 'package:sacny/feat/client/home_client/domain/repo/client_property_details_repo.dart';

class GetClientPropertyDetailsUseCase {
  final ClientPropertyDetailsRepo repository;

  GetClientPropertyDetailsUseCase({required this.repository});

  Future<Either<Fuiler, ClientPropertyDetailsEntity>> call(String propertyId) {
    return repository.getPropertyDetails(propertyId);
  } 


  Future<Either<Fuiler, void>> searchForProperty(String search) {
    return repository.searchForProperty(search);
  }
}
