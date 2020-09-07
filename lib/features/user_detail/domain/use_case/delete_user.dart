import 'package:dartz/dartz.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/params.dart';
import 'package:montageapp/core/use_case/use_case.dart';
import 'package:montageapp/features/user_detail/domain/repository/user_detail_repository.dart';

class DeleteUser implements UseCase<void, Params> {
  final UserDetailRepository userDetailRepository;

  DeleteUser(this.userDetailRepository);

  Future<Either<Failure, void>> call(Params params) async {
    return await userDetailRepository.deleteUser(params.user);
  }
}
