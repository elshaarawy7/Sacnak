class ClientProfileEntity {
  final String name;
  final String phone;
  final String? image;

  ClientProfileEntity({
    required this.name,
    required this.phone,
    this.image,
  });
}