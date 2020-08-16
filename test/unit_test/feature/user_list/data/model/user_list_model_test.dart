import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_list/data/model/user_list_model.dart';

import '../../../../core/dataset/test_data.dart';
import '../../../../core/fixtures/fixture_reader.dart';
import '../../../../core/helper/user_assertion.dart';

void main() {
  UserAssertions userAssertions;

  setUp(() {
    userAssertions = UserAssertions();
  });

  group('Should return a valid type from UserListModel', () {
    test('Should return a list of users from getParsedUserList method',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("user_list.json"));
      final result = UserListModel().getParsedUserList(jsonMap);
      expect(result, isA<List<User>>());
    });
  });

  group('Should return valid user objects from UserListModel', () {
    test('Should return valid male and female users from json parsing',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("user_list.json"));
      final result = UserListModel().getParsedUserList(jsonMap);

      expect(userAssertions.assertUser(result[0], tMaleUserModel), true);
      expect(userAssertions.assertUser(result[1], tFemaleUserModel), true);
    });
  });

  group('Should return valid conversion to json string', () {
    test('Should convert user list to json string correctly', () async {
      final List<User> userList = [tUserA, tUserB];
      final result = UserListModel().putJsonList(userList);
      expect(result, fixture("user_list_unformatted.json"));
    });
  });
}
