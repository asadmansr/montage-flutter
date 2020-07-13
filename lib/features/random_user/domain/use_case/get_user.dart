import 'package:dartz/dartz.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/no_params.dart';
import 'package:montageapp/core/use_case/use_case.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/domain/repository/user_repository.dart';

class GetUser implements UseCase<User, NoParams> {
  final UserRepository repository;

  GetUser(this.repository);

  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUser();
  }
}
