import 'package:dartz/dartz.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser();
}
