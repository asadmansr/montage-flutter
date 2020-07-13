import 'package:montageapp/features/random_user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<Either<Failure, User>> execute() async {
    return await repository.getUser();
  }
}
