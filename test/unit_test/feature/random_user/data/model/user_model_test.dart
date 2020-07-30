import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:montageapp/features/random_user/data/model/user_model.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

import '../../../../core/fixtures/fixture_reader.dart';
import '../../../../core/helper/user_assertion.dart';

void main() {

  UserAssertions userAssertions;

  final tMaleUserModel = UserModel(
      name: "Frederik Stenstad",
      email: "frederik.stenstad@example.com",
      userName: "blueswan657",
      password: "steph",
      address: "2391 Armauer Hansens gate, Hyggen, Møre og Romsdal, Norway",
      gender: "male",
      imgUrl: "assets/man_1.png"
  );

  final tFemaleUserModel = UserModel(
      name: "Saadia Droste",
      email: "saadia.droste@example.com",
      userName: "tinypeacock811",
      password: "1960",
      address: "9548 De Priorij, Greonterp, Noord-Brabant, Netherlands",
      gender: "female",
      imgUrl: "assets/woman_1.png"
  );

  setUp((){
    userAssertions = UserAssertions();
  });

  group('userModel should return a valid User object', () {
    test('user model should return User type', () async {
      expect(tMaleUserModel, isA<User>());
    });
  });

  group('userModel should return a valid fromJson representation', () {
    test('should get valid user object for male user', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("male_user.json"));
      final result = UserModel.fromJson(jsonMap);

      final actual = userAssertions.assertUserModel(result, tMaleUserModel);
      expect(actual, true);
    });

    test('should get valid user object for female user', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("female_user.json"));
      final result = UserModel.fromJson(jsonMap);

      final actual = userAssertions.assertUserModel(result, tFemaleUserModel);
      expect(actual, true);
    });
  });

  group('toJson should produce a valid json string', () {
    test('should get valid json string for male user', () async {
      final result = tMaleUserModel.toJson();

      final expectedJsonMap = {
        'name': "Frederik Stenstad",
        'email': "frederik.stenstad@example.com",
        'userName': "blueswan657",
        'password': "steph",
        'address': "2391 Armauer Hansens gate, Hyggen, Møre og Romsdal, Norway",
        'gender': "male",
        'imgUrl': "assets/man_1.png"
      };

      expect(result, expectedJsonMap);
    });

    test('should get valid json string for female user', () async {
      final result = tFemaleUserModel.toJson();

      final expectedJsonMap = {
        'name': "Saadia Droste",
        'email': "saadia.droste@example.com",
        'userName': "tinypeacock811",
        'password': "1960",
        'address': "9548 De Priorij, Greonterp, Noord-Brabant, Netherlands",
        'gender': "female",
        'imgUrl': "assets/woman_1.png"
      };

      expect(result, expectedJsonMap);
    });
  });
}
