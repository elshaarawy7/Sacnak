class ClientPropertyDetailsEntity {
  final String id;
  final double area;
  final double price;
  final String street;
  final String buildingNumber;
  final String apartmentNumber;
  final String city;
  final List<String> nearbyUniversities;
  final List<String> amenities;
  final List<String> images;
  final int bedrooms;
  final int rooms;
  final int bathrooms;
  final int availableBeds;
  final int occupiedBeds;
  final double? insurance;
  final bool isIncludesBills;
  final String status;

  ClientPropertyDetailsEntity({
    required this.id,
    required this.area,
    required this.price,
    required this.street,
    required this.buildingNumber,
    required this.apartmentNumber,
    required this.city,
    required this.nearbyUniversities,
    required this.amenities,
    required this.images,
    required this.bedrooms,
    required this.rooms,
    required this.bathrooms,
    required this.availableBeds,
    required this.occupiedBeds,
    this.insurance,
    required this.isIncludesBills,
    required this.status,
  });
}
