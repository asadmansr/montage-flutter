import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_detail/data/data_source/user_detail_data_source.dart';
import 'package:montageapp/features/user_detail/domain/repository/user_detail_repository.dart';

class UserDetailRepositoryImpl implements UserDetailRepository {
  final UserDetailLocalDataSource userDetailLocalDataSource;

  UserDetailRepositoryImpl({@required this.userDetailLocalDataSource});

  @override
  Future<Either<Failure, void>> deleteUser(User user) async {
    try {
      return Right(await userDetailLocalDataSource.deleteUser(user));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
