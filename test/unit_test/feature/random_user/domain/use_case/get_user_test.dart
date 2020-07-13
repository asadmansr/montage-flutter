import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/no_params.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/domain/repository/user_repository.dart';
import 'package:montageapp/features/random_user/domain/use_case/get_user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  GetUser getUserUseCase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    getUserUseCase = GetUser(mockUserRepository);
  });

  group('getUserUseCase should return an User object on success', () {
    final tUserA = User(
        name: "john smith",
        email: "john@example.com",
        userName: "john123",
        password: "johnPassword",
        address: "123 example st, City State");

    final tUserB = User(
        name: "Alice Smith",
        email: "alice@example.com",
        userName: "alice!@#",
        password: "aSJDIW@KSd293",
        address: "123 town rd, City State");

    test('should get valid UserB object from repository', () async {
      when(mockUserRepository.getUser()).thenAnswer((_) async => Right(tUserA));

      final result = await getUserUseCase(NoParams());

      expect(result, Right(tUserA));
      verify(mockUserRepository.getUser());
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should get valid UserA object from repository', () async {
      when(mockUserRepository.getUser()).thenAnswer((_) async => Right(tUserB));

      final result = await getUserUseCase(NoParams());

      expect(result, Right(tUserB));
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
