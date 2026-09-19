class PropertyEntity {
  final String id;

  final double area;
  final int bedrooms;
  final int rooms;
  final int bathrooms;

  final String city;
  final String street;
  final String buildingNumber;
  final String apartmentNumber;
  final List<String> nearbyUniversities;

  final double? latitude;
  final double? longitude;

  final double? price;
  final double? insurance;
  final bool? isIncludesBills;

  final String status;
  final DateTime? createdAt;
  final List<String> images;
  final List<String> amenities;

  PropertyEntity({
    required this.id,
    required this.area,
    required this.bedrooms,
    required this.rooms,
    required this.bathrooms,
    required this.city,
    required this.street,
    required this.buildingNumber,
    required this.apartmentNumber,
    this.nearbyUniversities = const [],
    this.latitude,
    this.longitude,
    this.price,
    this.insurance,
    this.isIncludesBills,
    required this.status,
    this.createdAt,
    this.images = const [],
    this.amenities = const [],
  });
}