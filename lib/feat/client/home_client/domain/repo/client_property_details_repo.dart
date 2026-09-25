import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/client/home_client/domain/entity/client_property_details_entity.dart';

abstract class ClientPropertyDetailsRepo {
  Future<Either<Fuiler, ClientPropertyDetailsEntity>> getPropertyDetails(String propertyId);
  Future<Either<Fuiler, void>> searchForProperty(String search);
}
