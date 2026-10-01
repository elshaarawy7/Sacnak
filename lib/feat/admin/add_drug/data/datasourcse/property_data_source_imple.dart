import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/core/server/cloudinary_service.dart';
import 'package:sacny/feat/admin/add_drug/data/datasourcse/property_data_source.dart';
import 'package:sacny/feat/admin/add_drug/data/models/property_model.dart';

class PropertyDataSourceImple implements PropertyDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final CloudinaryService cloudinaryService;

  PropertyDataSourceImple({
    required this.firebaseFirestore,
    required this.firebaseAuth,
    required this.cloudinaryService,
  });

  @override
  Future<Either<Fuiler, PropertyModel>> addProperty(
    PropertyModel propertyModel,
    List<XFile> imagesFiles,
  ) async {
    try {
      final owner = firebaseAuth.currentUser;
      if (owner == null) {
        throw StateError('سجل الدخول قبل إضافة عقار.');
      }

      final imageUrls = await cloudinaryService.uploadImages(imagesFiles);
      final propertyData = propertyModel.toJson()..['images'] = imageUrls;
      Map<String, dynamic> ownerProfile = {};
      try {
        final ownerSnapshot = await firebaseFirestore
            .collection('admin_suers')
            .doc(owner.uid)
            .get();
        ownerProfile = ownerSnapshot.data() ?? {};
      } catch (_) {}
      propertyData.addAll({
        'ownerId': owner.uid,
        'ownerName': ownerProfile['name'] ?? owner.displayName ?? 'مالك العقار',
        'ownerImage': ownerProfile['image'] ?? owner.photoURL ?? '',
        'ownerPhone': ownerProfile['phone'] ?? owner.phoneNumber ?? '',
      });

      await firebaseFirestore
          .collection("property")
          .add(propertyData)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception("انتهت مهلة الاتصال بالخادم. يرجى التحقق من الاتصال بالإنترنت أو إعدادات قاعدة البيانات.");
            },
          );  
      return Right(propertyModel);
    } catch (e) {
      return Left(ServerFuiler(e.toString().replaceAll("Exception: ", "")));
    }
  }
}