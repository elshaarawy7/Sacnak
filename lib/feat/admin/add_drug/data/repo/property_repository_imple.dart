import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/add_drug/data/datasourcse/property_data_source.dart';
import 'package:sacny/feat/admin/add_drug/data/models/property_model.dart';
import 'package:sacny/feat/admin/add_drug/data/repo/property_repository.dart';

class PropertyRepositoryImple extends PropertyRepository {
  PropertyDataSource propertyDataSource;

  PropertyRepositoryImple({required this.propertyDataSource});
  @override
  Future<Either<Fuiler, PropertyModel>> addProperty(
    PropertyModel propertyModel,
    List<XFile> images,
  ) async {
    try {
      final result = await propertyDataSource.addProperty(propertyModel, images);
      return result;
    } catch (e) {
      return Left(ServerFuiler(e.toString()));
    }
  }
}