import 'package:sacny/feat/admin/chats_admain/domain/entity/massege_clients_entity.dart';

class MassegeClientsModel extends MassegeClientsEntity {
  MassegeClientsModel({
    required super.id,
    required super.name,
    required super.message,
    required super.imageClient,
  });

  factory MassegeClientsModel.fromJson(Map<String, dynamic> json) {
    return MassegeClientsModel(
      id: json['id'],
      name: json['name'],
      message: json['message'],
      imageClient: json['image'],
    );
  }
}
