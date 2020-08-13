import 'package:dartz/dartz.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/no_params.dart';
import 'package:montageapp/core/use_case/use_case.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_list/domain/repository/user_list_repository.dart';

class GetUserList implements UseCase<List<User>, NoParams> {
  final UserListRepository repository;

  GetUserList(this.repository);

  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await repository.getUserList();
  }
}
