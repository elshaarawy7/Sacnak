import 'package:sacny/feat/admin/home_admain/domain/entity/entuty_cart_home_admin_model.dart';

class CartHomeModelAdmain extends EntutyCartHomeAdminModel {
  CartHomeModelAdmain({
    required super.id,
    required super.title,
    required super.price,
    required super.totalBeds,
    required super.occupiedBeds,
    required super.availableBeds,
    required super.isAvailable,
    required super.imageUrl,
  });

  factory CartHomeModelAdmain.fromJson(
    Map<String, dynamic> json, {
    String id = '',
  }) {
    // Build a title from city + street + apartment number
    final city = json['city'] ?? '';
    final street = json['street'] ?? '';
    final apartmentNumber = json['apartmentNumber'] ?? '';
    final title = '$city - $street - شقة $apartmentNumber'.trim();

    // price stored as double in Firestore
    final price = ((json['price'] as num?) ?? 0).toInt();

    // bedrooms stored as 'bedrooms' – this is the total number of beds
    final totalBeds = (json['bedrooms'] as num?)?.toInt() ?? 0;

    // availableBeds = bedrooms that are not yet occupied
    // If Firestore has a dedicated field use it; otherwise fall back to totalBeds
    final occupiedBeds = (json['occupiedBeds'] as num?)?.toInt() ?? 0;
    final availableBeds = ((json['availableBeds'] as num?)?.toInt() ??
        (totalBeds - occupiedBeds))
      .clamp(0, totalBeds)
      .toInt();

    // status: 'available' means available, anything else means rented
    final isAvailable = (json['status'] ?? 'available') == 'available';

    // images is a List<String>, take the first one or empty string
    final images = json['images'];
    String imageUrl = '';
    if (images is List && images.isNotEmpty) {
      imageUrl = images.first.toString();
    }

    return CartHomeModelAdmain(
      id: id,
      title: title,
      price: price,
      totalBeds: totalBeds,
      occupiedBeds: occupiedBeds.clamp(0, totalBeds).toInt(),
      availableBeds: availableBeds,
      isAvailable: availableBeds > 0 && isAvailable,
      imageUrl: imageUrl,
    );
  }
}