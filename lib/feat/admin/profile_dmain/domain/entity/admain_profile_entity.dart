class AdminProfileEntity {
  final String name;
  final String phone;
  final String? image;

  AdminProfileEntity({
    required this.name,
    required this.phone,
    this.image,
  });
}