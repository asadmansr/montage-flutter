import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/database/database_helper.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/features/user_list/data/data_source/user_list_local_data_source.dart';

import '../../../../core/dataset/test_data.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  UserListLocalDataSourceImpl userListLocalDataSourceImpl;
  MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    userListLocalDataSourceImpl =
        UserListLocalDataSourceImpl(client: mockDatabaseHelper);
  });

  group('Should return valid user objects from database filled with users', () {
    Map<String, dynamic> rowUserA = {
      DatabaseHelper.colId: 1,
      DatabaseHelper.colName: tUserA.name,
      DatabaseHelper.colEmail: tUserA.email,
      DatabaseHelper.colUserName: tUserA.userName,
      DatabaseHelper.colPassword: tUserA.password,
      DatabaseHelper.colAddress: tUserA.address,
      DatabaseHelper.colGender: tUserA.gender,
      DatabaseHelper.colImgUrl: tUserA.imgUrl
    };

    Map<String, dynamic> rowUserB = {
      DatabaseHelper.colId: 2,
      DatabaseHelper.colName: tUserB.name,
      DatabaseHelper.colEmail: tUserB.email,
      DatabaseHelper.colUserName: tUserB.userName,
      DatabaseHelper.colPassword: tUserB.password,
      DatabaseHelper.colAddress: tUserB.address,
      DatabaseHelper.colGender: tUserB.gender,
      DatabaseHelper.colImgUrl: tUserB.imgUrl
    };

    final singleUserList = Future.value([rowUserA]);
    final multipleUserList = Future.value([rowUserA, rowUserB]);

    final singleExpected = [tUserA];
    final multipleExpected = [tUserA, tUserB];

    test('Should return valid user list of a single saved user', () async {
      when(mockDatabaseHelper.queryAllRows())
          .thenAnswer((_) async => Future.value(singleUserList));

      final result = await userListLocalDataSourceImpl.getUserList();
      verify(mockDatabaseHelper.queryAllRows());
      expect(result.length, 1);
      expect(result, singleExpected);
    });

    test('Should return valid user list of multiple saved users', () async {
      when(mockDatabaseHelper.queryAllRows())
          .thenAnswer((_) async => Future.value(multipleUserList));

      final result = await userListLocalDataSourceImpl.getUserList();
      verify(mockDatabaseHelper.queryAllRows());
      expect(result.length, 2);
      expect(result, multipleExpected);
    });
  });

  group('Should return valid exception when database is empty', () {
    List<Map<String, dynamic>> emptyList = List<Map<String, dynamic>>();
    final emptyUserList = Future.value(emptyList);

    test('Should return CacheException when database is empty', () async {
      when(mockDatabaseHelper.queryAllRows())
          .thenAnswer((_) async => Future.value(emptyUserList));

      final call = userListLocalDataSourceImpl.getUserList;
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });
}
