import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_list/data/data_source/user_list_local_data_source.dart';
import 'package:montageapp/features/user_list/data/repository/user_list_repository_impl.dart';

import '../../../../core/dataset/test_data.dart';

class MockUserListLocalDataSource extends Mock
    implements UserListLocalDataSource {}

void main() {
  MockUserListLocalDataSource mockUserListLocalDataSource;
  UserListRepositoryImpl userListRepositoryImpl;
  List<User> userList;

  setUp(() {
    mockUserListLocalDataSource = MockUserListLocalDataSource();
    userListRepositoryImpl = UserListRepositoryImpl(
        userListLocalDataSource: mockUserListLocalDataSource);
    userList = [tUserA, tUserB];
  });

  group('Should return a valid response from cache data source', () {
    test(
        'Should return a valid user list when repository calls cache data source',
        () async {
      when(mockUserListLocalDataSource.getUserList())
          .thenAnswer((_) async => userList);

      final result = await userListRepositoryImpl.getUserList();
      final actual = result.getOrElse(null);

      verify(mockUserListLocalDataSource.getUserList());
      expect(actual.length, 2);
      expect(actual[0], tUserA);
      expect(actual[1], tUserB);
    });
  });

  group('Should return a valid exception from cache data source', () {
    test(
        'Should return a cache failure when cache data source throws a cache exception',
        () async {
      when(mockUserListLocalDataSource.getUserList())
          .thenThrow(CacheException());

      final result = await userListRepositoryImpl.getUserList();

      verify(mockUserListLocalDataSource.getUserList());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
