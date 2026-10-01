import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart'; 
import 'package:sacny/feat/admin/chats_admain/data/model/maasege_clients_model.dart';

abstract class MassegeClientsRemoteDataSource {
  Future<List<MassegeClientsModel>> getMassegeClients();
}

