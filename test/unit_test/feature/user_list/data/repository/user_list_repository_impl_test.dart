import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_list/data/data_source/user_list_data_source.dart';
import 'package:montageapp/features/user_list/data/repository/user_list_repository_impl.dart';

import '../../../../core/dataset/test_data.dart';

class MockUserListDataSource extends Mock implements UserListDataSource {}

void main() {
  MockUserListDataSource mockUserListDataSource;
  UserListRepositoryImpl userListRepositoryImpl;
  List<User> userList;

  setUp(() {
    mockUserListDataSource = MockUserListDataSource();
    userListRepositoryImpl =
        UserListRepositoryImpl(userListDataSource: mockUserListDataSource);
    userList = [tUserA, tUserB];
  });

  group('Should return a valid response from cache data source', () {
    test(
        'Should return a valid user list when repository calls cache data source',
        () async {
      when(mockUserListDataSource.getUserList())
          .thenAnswer((_) async => userList);

      final result = await userListRepositoryImpl.getUserList();
      final actual = result.getOrElse(null);

      verify(mockUserListDataSource.getUserList());
      expect(actual.length, 2);
      expect(actual[0], tUserA);
      expect(actual[1], tUserB);
    });
  });

  group('Should return a valid exception from cache data source', () {
    test(
        'Should return a cache failure when cache data source throws a cache exception',
        () async {
      when(mockUserListDataSource.getUserList()).thenThrow(CacheException());

      final result = await userListRepositoryImpl.getUserList();

      verify(mockUserListDataSource.getUserList());
      expect(result, equals(Left(CacheFailure())));
    });
  });

  group('Should perform valid save operations in data source', () {
    List<User> userList = [tUserA, tUserB];

    test('Should be able to save list in the data source', () async {
      when(mockUserListDataSource.cacheUserList(any))
        ..thenAnswer((_) async => Right(null));

      await userListRepositoryImpl.saveUserList(userList);

      verify(mockUserListDataSource.cacheUserList(userList));
    });

    test('Should be able to return failure if save is not successful', () async {
      when(mockUserListDataSource.cacheUserList(any))
          .thenThrow(CacheException());

      final result = await userListRepositoryImpl.saveUserList(userList);

      verify(mockUserListDataSource.cacheUserList(userList));
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
