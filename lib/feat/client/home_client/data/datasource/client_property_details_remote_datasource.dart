import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/client/home_client/data/models/client_property_details_model.dart';

abstract class ClientPropertyDetailsRemoteDataSource {
  Future<Either<Fuiler, ClientPropertyDetailsModel>> getPropertyDetails(String propertyId);
  Future<Either<Fuiler, void>> searchForProperty(String search);
}

class ClientPropertyDetailsRemoteDataSourceImpl implements ClientPropertyDetailsRemoteDataSource {
  final FirebaseFirestore firestore;

  ClientPropertyDetailsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<Either<Fuiler, ClientPropertyDetailsModel>> getPropertyDetails(String propertyId) async {
    try {
      final doc = await firestore.collection('property').doc(propertyId).get();
      if (!doc.exists || doc.data() == null) {
        return Left(ServerFuiler("لم يتم العثور على بيانات هذا العقار"));
      }
      return Right(ClientPropertyDetailsModel.fromJson(doc.data()!, id: doc.id));
    } catch (e) {
      return Left(ServerFuiler(e.toString().replaceAll("Exception: ", "")));
    }
  }

  @override
  Future<Either<Fuiler, void>> searchForProperty(String search) async {
     try {
      return Right(null);
    } catch (e) {
      return Left(ServerFuiler(e.toString().replaceAll("Exception: ", "")));
    }
  }
}
