import 'package:sacny/feat/admin/profile_dmain/domain/entity/admain_profile_entity.dart';

class ProfileAdmainModel extends AdminProfileEntity {
  ProfileAdmainModel({
    required String name,
    required String phone,
    String? image,
  }) : super(name: name, phone: phone, image: image);

  factory ProfileAdmainModel.fromJson(Map<String, dynamic> json) {
    return ProfileAdmainModel(
      name: json['name'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String?,
    );
  }
}
