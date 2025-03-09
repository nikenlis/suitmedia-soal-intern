import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:suitmedia/core/error/failures.dart';


import '../../../../core/error/excaption.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failures, List<UserEntity>>> getAllUser(int page) async {
    bool online = await networkInfo.isConnected();

    if (online) {
      try {
        final result = await remoteDataSource.getAllUser(page);
        await localDataSource.cachedAll(result);
        return Right(result.map((e) => e.toEntity).toList());
      } on TimeoutException {
        return const Left(NotFoundFailure('Timeout. No Response'));
      } on NotFoundExcaption catch (e) {
        return Left(NotFoundFailure(e.message.toString()));
      } on ServerExcaption {
        return const Left(ServerFailure('Server Error'));
      } catch (e) {
        return const Left(ServerFailure('Something Went Wrong'));
      }
    } else {
      try {
        final result = await localDataSource.getAllUser();
        return Right(result.map((e) => e.toEntity).toList());
      } on CachedExcaption {
        return const Left(CachedFailure('Data is not Present'));
      }
    }
  }
}
