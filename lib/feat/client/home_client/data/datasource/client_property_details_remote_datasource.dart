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
      
      final data = Map<String, dynamic>.from(doc.data()!);
      String? ownerName = data['ownerName'] ?? data['adminName'] ?? data['name'];
      String? ownerPhone = data['ownerPhone'] ?? data['adminPhone'] ?? data['phone'];
      String? ownerImage = data['ownerImage'] ?? data['adminImage'] ?? data['image'];
      String? adminId = data['adminId'] ?? data['ownerId'] ?? data['userId'];

      if (adminId != null && adminId.toString().isNotEmpty) {
        try {
          final adminDoc = await firestore.collection('admin_suers').doc(adminId.toString()).get();
          if (adminDoc.exists && adminDoc.data() != null) {
            final adminData = adminDoc.data()!;
            ownerName = adminData['name']?.toString() ?? ownerName;
            ownerPhone = adminData['phone']?.toString() ?? ownerPhone;
            ownerImage = adminData['image']?.toString() ?? ownerImage;
          }
        } catch (_) {}
      }

      data['ownerName'] = ownerName ?? 'مالك العقار';
      data['ownerPhone'] = ownerPhone ?? '';
      data['ownerImage'] = ownerImage ?? '';
      data['ownerId'] = adminId ?? '';

      return Right(ClientPropertyDetailsModel.fromJson(data, id: doc.id));
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
