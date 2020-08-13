import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/no_params.dart';
import 'package:montageapp/features/random_user/domain/repository/user_repository.dart';
import 'package:montageapp/features/random_user/domain/use_case/get_user.dart';

import '../../../../core/dataset/test_data.dart';
import '../../../../core/helper/user_assertion.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  GetUser getUserUseCase;
  MockUserRepository mockUserRepository;
  UserAssertions userAssertions;

  setUp(() {
    mockUserRepository = MockUserRepository();
    getUserUseCase = GetUser(mockUserRepository);
    userAssertions = UserAssertions();
  });

  group('getUserUseCase should return an User object on success', () {
    test('should get valid UserB object from repository', () async {
      when(mockUserRepository.getUser()).thenAnswer((_) async => Right(tUserA));

      final result = await getUserUseCase(NoParams());
      final actual = userAssertions.assertUser(result.getOrElse(null), tUserA);

      expect(result, Right(tUserA));
      expect(actual, true);
      verify(mockUserRepository.getUser());
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should get valid UserA object from repository', () async {
      when(mockUserRepository.getUser()).thenAnswer((_) async => Right(tUserB));

      final result = await getUserUseCase(NoParams());
      final actual = userAssertions.assertUser(result.getOrElse(null), tUserB);

      expect(result, Right(tUserB));
      expect(actual, true);
      verify(mockUserRepository.getUser());
      verifyNoMoreInteractions(mockUserRepository);
    });
  });

  group('getUserUseCase should return a Failure object on failure', () {
    test('should get ServerFailure when repository return a failure', () async {
      when(mockUserRepository.getUser())
          .thenAnswer((_) async => Left(ServerFailure()));

      final result = await getUserUseCase(NoParams());

      expect(result, Left(ServerFailure()));
      verify(mockUserRepository.getUser());
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
