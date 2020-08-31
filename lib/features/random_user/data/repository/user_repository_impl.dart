import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/network/network_info.dart';
import 'package:montageapp/features/random_user/data/data_source/user_local_data_source.dart';
import 'package:montageapp/features/random_user/data/data_source/user_remote_data_source.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {@required this.localDataSource,
      @required this.remoteDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, User>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.getUser();
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoNetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUser(User user) async {
    try {
      return Right(await localDataSource.saveUser(user));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
