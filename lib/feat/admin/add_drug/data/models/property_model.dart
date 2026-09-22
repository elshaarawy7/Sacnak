import 'package:sacny/feat/admin/add_drug/domain/entity/property_entity.dart';

class PropertyModel extends PropertyEntity {
  PropertyModel({
    required super.id,
    required super.area,
    required super.bedrooms,
    required super.rooms,
    required super.bathrooms,
    required super.city,
    required super.street,
    required super.buildingNumber,
    required super.apartmentNumber,
    super.nearbyUniversities,
    super.latitude,
    super.longitude,
    super.price,
    super.insurance,
    super.isIncludesBills,
    required super.status,
    super.images,
    super.amenities,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      images: (json['images'] as List<dynamic>?)
              ?.map((image) => image.toString())
              .toList() ??
          const [],
      amenities: (json['amenities'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          const [],
      id: json['id'] ?? '',
      area: (json['area'] as num?)?.toDouble() ?? 0.0,
      bedrooms: json['bedrooms'] ?? 0,
      rooms: json['rooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      buildingNumber: json['buildingNumber'] ?? '',
      apartmentNumber: json['apartmentNumber'] ?? '',
      nearbyUniversities: (json['nearbyUniversities'] as List<dynamic>?)
              ?.map((university) => university.toString())
              .toList() ??
          const [],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      insurance: (json['insurance'] as num?)?.toDouble(),
      isIncludesBills: json['isIncludesBills'] ?? false,
      status: json['status'] ?? 'available',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area': area,
      'bedrooms': bedrooms,
      'rooms': rooms,
      'bathrooms': bathrooms,
      'city': city,
      'street': street,
      'buildingNumber': buildingNumber,
      'apartmentNumber': apartmentNumber,
      'nearbyUniversities': nearbyUniversities,
      'latitude': latitude,
      'longitude': longitude,
      'price': price,
      'insurance': insurance,
      'isIncludesBills': isIncludesBills,
      'status': status,
      'occupiedBeds': 0,
      'availableBeds': bedrooms,
      'images': images,
      'amenities': amenities,
    };
  }
}