import 'package:dartz/dartz.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/params.dart';
import 'package:montageapp/core/use_case/use_case.dart';
import 'package:montageapp/features/random_user/domain/repository/user_repository.dart';

class SaveUser implements UseCase<void, Params> {
  final UserRepository repository;

  SaveUser(this.repository);

  Future<Either<Failure, void>> call(Params params) async {
    return await repository.saveUser(params.user);
  }
}
