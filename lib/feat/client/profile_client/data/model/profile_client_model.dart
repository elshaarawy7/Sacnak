import 'package:sacny/feat/client/profile_client/domain/entity/client_profile_entity.dart';

class ProfileAdmainModel extends ClientProfileEntity {
  ProfileAdmainModel({
    required super.name,
    required super.phone,
    super.image,
  });

  factory ProfileAdmainModel.fromJson(Map<String, dynamic> json) {
    return ProfileAdmainModel(
      name: json['name'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String?,
    );
  }
}
