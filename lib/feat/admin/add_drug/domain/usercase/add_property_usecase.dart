import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/add_drug/data/models/property_model.dart';
import 'package:sacny/feat/admin/add_drug/data/repo/property_repository.dart';

class AddPropetryUseCase {
  final PropertyRepository propertyRepository; 

  AddPropetryUseCase({required this.propertyRepository}); 

  Future<Either<Fuiler, PropertyModel>> call(
    PropertyModel propertyModel,
    List<XFile> images,
  ) async {
    return propertyRepository.addProperty(propertyModel, images);
  }
}