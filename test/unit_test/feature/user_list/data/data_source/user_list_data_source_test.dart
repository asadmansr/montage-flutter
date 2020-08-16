import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_list/data/data_source/user_list_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/dataset/test_data.dart';
import '../../../../core/fixtures/fixture_reader.dart';
import '../../../../core/helper/user_assertion.dart';

class MockSharedPreference extends Mock implements SharedPreferences {}

void main() {
  UserListDataSourceImpl userListDataSourceImpl;
  MockSharedPreference mockSharedPreference;
  UserAssertions userAssertions;

  setUp(() {
    mockSharedPreference = MockSharedPreference();
    userListDataSourceImpl =
        UserListDataSourceImpl(sharedPreferences: mockSharedPreference);
    userAssertions = UserAssertions();
  });

  group('Should perform valid operations for retrieving cache', () {
    test('Should return valid user list from sharedPreference', () async {
      when(mockSharedPreference.getString(any))
          .thenReturn(fixture('user_list.json'));

      final result = await userListDataSourceImpl.getUserList();

      verify(mockSharedPreference.getString('MONTAGE_CACHED_USER_LIST'));
      expect(userAssertions.assertUser(result[0], tMaleUserModel), true);
      expect(userAssertions.assertUser(result[1], tFemaleUserModel), true);
    });

    test('Should return valid exception if sharedPreference is empty', () async {
      when(mockSharedPreference.getString(any)).thenReturn(null);

      final call = userListDataSourceImpl.getUserList;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('Should perform valid operations for storing cache', () {
    test('Should perform valid operation when storing a user list', () async {
      final List<User> userList = [tUserA, tUserB];
      userListDataSourceImpl.cacheUserList(userList);
      final expectedJsonString = fixture("user_list_unformatted.json");

      verify(mockSharedPreference.setString(
          'MONTAGE_CACHED_USER_LIST', expectedJsonString));
    });
  });
}
