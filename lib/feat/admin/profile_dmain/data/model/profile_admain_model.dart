import 'package:sacny/feat/client/profile_client/domain/entity/client_profile_entity.dart';

class ProfileAdminModel extends ClientProfileEntity {
  ProfileAdminModel({
    required super.name,
    required super.phone,
    super.image,
  });

  factory ProfileAdminModel.fromJson(Map<String, dynamic> json) {
    return ProfileAdminModel(
      name: json['name'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String?,
    );
  }
}
