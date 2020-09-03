import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/params.dart';
import 'package:montageapp/features/random_user/domain/repository/user_repository.dart';
import 'package:montageapp/features/random_user/domain/use_case/save_user.dart';

import '../../../../core/dataset/test_data.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  SaveUser saveUser;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    saveUser = SaveUser(mockUserRepository);
  });

  group('Save user use case should return valid operations', () {
    test('Should return valid operations when saving new user', () async {
      when(mockUserRepository.saveUser(any))
          .thenAnswer((_) async => Right(null));

      await saveUser(Params(user: tUserA));

      verify(mockUserRepository.saveUser(tUserA));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });

  group('Save user use case should return valid exception', () {
    test('Should return exception if repository returns exception', () async {
      when(mockUserRepository.saveUser(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final result = await saveUser(Params(user: tUserA));

      expect(result, Left(CacheFailure()));
      verify(mockUserRepository.saveUser(tUserA));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
