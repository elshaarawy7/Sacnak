import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sacny/feat/admin/add_drug/data/models/property_model.dart';
import 'package:sacny/feat/admin/add_drug/data/repo/property_repository.dart';
import 'package:sacny/feat/admin/add_drug/domain/usercase/add_property_usecase.dart';
import 'package:sacny/feat/admin/add_drug/presentation/cubit/propetry_state.dart';


class PropertyCubit extends Cubit<AddPropetryState> {
  final AddPropetryUseCase addPropertyUseCase;
  final PropertyRepository repository;

  PropertyCubit({
    required this.addPropertyUseCase,
    required this.repository,
  }) : super(AddPropetryInitial());

  Future<void> addProperty({
    required double area,
    required int bedrooms,
    required int rooms,
    required int bathrooms,
    required String city,
    required String street,
    required String buildingNumber,
    required String apartmentNumber,
    List<String> nearbyUniversities = const [],
    List<String> amenities = const [],
    double? latitude,
    double? longitude,
    double? price,
    double? insurance,
    bool? isIncludesBills,
    List<XFile> images = const [],
  }) async {
    emit(AddPropetryLoading());

    try {
      final propertyModel = PropertyModel(
        id: '',
        area: area,
        bedrooms: bedrooms,
        rooms: rooms,
        bathrooms: bathrooms,
        city: city,
        street: street,
        buildingNumber: buildingNumber,
        apartmentNumber: apartmentNumber,
        nearbyUniversities: nearbyUniversities,
        amenities: amenities,
        latitude: latitude,
        longitude: longitude,
        price: price,
        insurance: insurance,
        isIncludesBills: isIncludesBills,
        status: 'available',
      );

      final result = await addPropertyUseCase(propertyModel, images);

      result.fold(
        (l) {
          emit(AddPropetryError(error: l.message));
        },
        (r) {
          emit(AddPropertySucsess(propertyEntity: r));
        },
      );
    } catch (e) {
      emit(AddPropetryError(error: e.toString()));
    }
  }

  
} 

//       emit(AddPropertySucsess(propertyEntity: property));
