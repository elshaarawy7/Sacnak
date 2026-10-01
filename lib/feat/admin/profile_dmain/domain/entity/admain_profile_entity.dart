class ProfileAdminEntity {
  final String adminName;
  final String adminPhone;
  final String? adminImage;

  ProfileAdminEntity({
    required this.adminName,
    required this.adminPhone,
    this.adminImage,
  });
}