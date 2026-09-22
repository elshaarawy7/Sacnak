abstract class EntutyCartHomeAdminModel {
  final String id;
  final String title;
  final int price;
  final int totalBeds;
  final int occupiedBeds;
  final int availableBeds;
  final bool isAvailable;
  final String imageUrl;

  EntutyCartHomeAdminModel({
    required this.id,
    required this.title,
    required this.price,
    required this.totalBeds,
    required this.occupiedBeds,
    required this.availableBeds,
    required this.isAvailable,
    required this.imageUrl,
  });
}