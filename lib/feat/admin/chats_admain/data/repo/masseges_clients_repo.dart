import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/chats_admain/data/datasource/data_source_massege_client.dart';
import 'package:sacny/feat/admin/chats_admain/domain/entity/massege_clients_entity.dart';

// 1. تعريف الـ Abstract Class (الإنترفيس)
abstract class RepoMassegeClients {
  Future<Either<Fuiler, List<MassegeClientsEntity>>> getMassegeClients();
}


class MassegesClientsRepoImpl implements RepoMassegeClients {
  final MassegeClientsRemoteDataSource massegeClientsRemoteDataSource;

  MassegesClientsRepoImpl({required this.massegeClientsRemoteDataSource});

  @override
  Future<Either<Fuiler, List<MassegeClientsEntity>>> getMassegeClients() async {
    try {
      final result = await massegeClientsRemoteDataSource.getMassegeClients();
      return Right(result);
    } catch (e) {
      return Left(ServerFuiler('حدث خطأ، أعد المحاولة'));
    }
  }
}