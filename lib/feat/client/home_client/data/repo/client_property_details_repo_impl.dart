import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/client/home_client/data/datasource/client_property_details_remote_datasource.dart';
import 'package:sacny/feat/client/home_client/domain/entity/client_property_details_entity.dart';
import 'package:sacny/feat/client/home_client/domain/repo/client_property_details_repo.dart';

class ClientPropertyDetailsRepoImpl implements ClientPropertyDetailsRepo {
  final ClientPropertyDetailsRemoteDataSource remoteDataSource;

  ClientPropertyDetailsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Fuiler, ClientPropertyDetailsEntity>> getPropertyDetails(String propertyId) {
    return remoteDataSource.getPropertyDetails(propertyId);
  }

  @override
  Future<Either<Fuiler, void>> searchForProperty(String search) {
    return remoteDataSource.searchForProperty(search);
  }
}
