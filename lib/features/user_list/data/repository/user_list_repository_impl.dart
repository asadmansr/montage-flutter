import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_list/data/data_source/user_list_data_source.dart';
import 'package:montageapp/features/user_list/domain/repository/user_list_repository.dart';

class UserListRepositoryImpl extends UserListRepository {
  final UserListDataSource userListDataSource;

  UserListRepositoryImpl({@required this.userListDataSource});

  @override
  Future<Either<Failure, List<User>>> getUserList() async {
    try {
      final userList = await userListDataSource.getUserList();
      return Right(userList);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
