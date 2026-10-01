import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sacny/feat/admin/chats_admain/data/datasource/data_source_massege_client.dart';
import 'package:sacny/feat/admin/chats_admain/data/model/maasege_clients_model.dart';

class DatasourceMassegeClienrsImple implements MassegeClientsRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  DatasourceMassegeClienrsImple({required this.firebaseFirestore});

  @override
  Future<List<MassegeClientsModel>> getMassegeClients() async {
    final response = await firebaseFirestore.collection('masseges_clients').get();
    
    final massegeClients = response.docs
        .map((doc) => MassegeClientsModel.fromJson(doc.data()))
        .toList();

    return massegeClients;
  }
}