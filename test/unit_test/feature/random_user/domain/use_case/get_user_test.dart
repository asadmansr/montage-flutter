import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/domain/repository/user_repository.dart';
import 'package:montageapp/features/random_user/domain/use_case/get_user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  GetUser getUser;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    getUser = GetUser(mockUserRepository);
  });

  final tUser = User(
      name: "john smith",
      email: "john@example.com",
      userName: "john123",
      password: "johnPassword",
      address: "123 example st, City State");

  test(
    'should get valid User object from repository', () async {
      when(mockUserRepository.getUser())
          .thenAnswer((_) async => Right(tUser));

      final result = await getUser.execute();

      expect(result, Right(tUser));
      verify(mockUserRepository.getUser());
      verifyNoMoreInteractions(mockUserRepository);
  });
}
