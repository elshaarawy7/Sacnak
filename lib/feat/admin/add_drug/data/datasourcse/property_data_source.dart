import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/add_drug/data/models/property_model.dart';

abstract class PropertyDataSource {
  Future<Either<Fuiler, PropertyModel>> addProperty(PropertyModel propertyModel , List<XFile> imagesFiles,);
}