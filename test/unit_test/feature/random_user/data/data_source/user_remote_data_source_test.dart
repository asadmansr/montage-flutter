import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/features/random_user/data/data_source/user_remote_data_source.dart';
import 'package:montageapp/features/random_user/data/model/user_model.dart';

import '../../../../core/fixtures/fixture_reader.dart';
import '../../../../core/helper/user_assertion.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  UserRemoteDataSourceImpl userRemoteDataSourceImpl;
  MockHttpClient mockHttpClient;
  UserAssertions userAssertions;

  setUp(() {
    mockHttpClient = MockHttpClient();
    userRemoteDataSourceImpl = UserRemoteDataSourceImpl(client: mockHttpClient);
    userAssertions = UserAssertions();
  });

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

  final url = 'https://randomuser.me/api/?nat=au,br,ca,ch,de,dk,fi,fr,gb,ei,nl,nz,us';
  final headers = {'Content-Type': 'application/json'};

  group('user remote data source returning successful http GET', () {
    test('user data source should make http GET request for male user', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('male_user.json'), 200));

      userRemoteDataSourceImpl.getUser();
      verify(mockHttpClient.get(url, headers: headers));
    });

    test('user data source should make http GET request for female user', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
              (_) async => http.Response(fixture('female_user.json'), 200));

      userRemoteDataSourceImpl.getUser();
      verify(mockHttpClient.get(url, headers: headers));
    });

    test('user data source should return valid male user model upon success', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('male_user.json'), 200));

      final result = await userRemoteDataSourceImpl.getUser();
      final actual = userAssertions.assertUserModel(result, tMaleUserModel);
      expect(actual, true);
    });

    test('user data source should return valid female user model upon success', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
              (_) async => http.Response(fixture('female_user.json'), 200));

      final result = await userRemoteDataSourceImpl.getUser();
      final actual = userAssertions.assertUserModel(result, tFemaleUserModel);
      expect(actual, true);
      //expect(result, equals(tFemaleUserModel));
    });
  });

  group('user remote data source returning failed http GET', () {
    test('data source should throw exception if response code is not 200', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('error.json'), 500));

      final call = userRemoteDataSourceImpl.getUser;
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
