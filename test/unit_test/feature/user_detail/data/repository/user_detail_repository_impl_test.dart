import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/features/user_detail/data/data_source/user_detail_data_source.dart';
import 'package:montageapp/features/user_detail/data/repository/user_detail_repository_impl.dart';

import '../../../../core/dataset/test_data.dart';

class MockDetailLocalDataSource extends Mock
    implements UserDetailLocalDataSource {}

void main() {
  UserDetailRepositoryImpl userDetailRepositoryImpl;
  MockDetailLocalDataSource mockDetailLocalDataSource;

  setUp(() {
    mockDetailLocalDataSource = MockDetailLocalDataSource();
    userDetailRepositoryImpl = UserDetailRepositoryImpl(
        userDetailLocalDataSource: mockDetailLocalDataSource);
  });

  group('should be able to delete a user', () {
    test('should call delete user in local data source when deleting user',
        () async {
      when(mockDetailLocalDataSource.deleteUser(any))
          .thenAnswer((_) async => null);
      userDetailRepositoryImpl.deleteUser(tMaleUserModel);
      verify(mockDetailLocalDataSource.deleteUser(tMaleUserModel));
    });

    test('should return valid cache failure when cache exception is thrown',
        () async {
      when(mockDetailLocalDataSource.deleteUser(any))
          .thenThrow(CacheException());
      final result = await userDetailRepositoryImpl.deleteUser(tMaleUserModel);
      verify(mockDetailLocalDataSource.deleteUser(tMaleUserModel));
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
