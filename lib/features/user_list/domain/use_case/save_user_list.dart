import 'package:dartz/dartz.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/params.dart';
import 'package:montageapp/core/use_case/use_case.dart';
import 'package:montageapp/features/user_list/domain/repository/user_list_repository.dart';

class SaveUserList implements UseCase<void, Params> {
  final UserListRepository repository;

  SaveUserList(this.repository);

  Future<Either<Failure, void>> call(Params params) async {
    return await repository.saveUserList(params.list);
  }
}
