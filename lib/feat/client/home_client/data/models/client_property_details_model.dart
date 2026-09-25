import 'package:sacny/feat/client/home_client/domain/entity/client_property_details_entity.dart';

class ClientPropertyDetailsModel extends ClientPropertyDetailsEntity {
  ClientPropertyDetailsModel({
    required super.id,
    required super.area,
    required super.price,
    required super.street,
    required super.buildingNumber,
    required super.apartmentNumber,
    required super.city,
    required super.nearbyUniversities,
    required super.amenities,
    required super.images,
    required super.bedrooms,
    required super.rooms,
    required super.bathrooms,
    required super.availableBeds,
    required super.occupiedBeds,
    super.insurance,
    required super.isIncludesBills,
    required super.status,
  });

  factory ClientPropertyDetailsModel.fromJson(Map<String, dynamic> json, {String id = ''}) {
    final imagesList = (json['images'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        const [];

    final universitiesList = (json['nearbyUniversities'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        const [];

    final amenitiesList = (json['amenities'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        const [];

    final bedrooms = (json['bedrooms'] as num?)?.toInt() ?? 0;
    final occupiedBeds = (json['occupiedBeds'] as num?)?.toInt() ?? 0;
    final availableBeds = ((json['availableBeds'] as num?)?.toInt() ??
        (bedrooms - occupiedBeds))
      .clamp(0, bedrooms)
      .toInt();

    return ClientPropertyDetailsModel(
      id: id.isNotEmpty ? id : (json['id'] ?? ''),
      area: (json['area'] as num?)?.toDouble() ?? 0.0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      street: json['street']?.toString() ?? '',
      buildingNumber: json['buildingNumber']?.toString() ?? '',
      apartmentNumber: json['apartmentNumber']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      nearbyUniversities: universitiesList,
      amenities: amenitiesList,
      images: imagesList,
      bedrooms: bedrooms,
      rooms: (json['rooms'] as num?)?.toInt() ?? 0,
      bathrooms: (json['bathrooms'] as num?)?.toInt() ?? 0,
      availableBeds: availableBeds,
      occupiedBeds: occupiedBeds,
      insurance: (json['insurance'] as num?)?.toDouble(),
      isIncludesBills: json['isIncludesBills'] ?? false,
      status: json['status']?.toString() ?? 'available',
    );
  }
}
