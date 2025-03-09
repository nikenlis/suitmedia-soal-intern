
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';


class GetAllUserUsecase {
  final UserRepository repository;
  GetAllUserUsecase(this.repository,);

  Future<Either<Failures, List<UserEntity>>> execute (int page) async {
    return await repository.getAllUser(page);
  }
}
