import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/params.dart';
import 'package:montageapp/features/user_detail/domain/repository/user_detail_repository.dart';
import 'package:montageapp/features/user_detail/domain/use_case/delete_user.dart';

import '../../../../core/dataset/test_data.dart';

class MockUserDetailRepository extends Mock implements UserDetailRepository {}

void main() {
  DeleteUser deleteUser;
  MockUserDetailRepository mockUserDetailRepository;

  setUp(() {
    mockUserDetailRepository = MockUserDetailRepository();
    deleteUser = DeleteUser(mockUserDetailRepository);
  });

  group('Delete user use case should return valid operations', () {
    test('Should return valid operations when deleting user', () async {
      when(mockUserDetailRepository.deleteUser(any))
          .thenAnswer((_) async => Right(null));

      await deleteUser(Params(user: tUserA));

      verify(mockUserDetailRepository.deleteUser(tUserA));
      verifyNoMoreInteractions(mockUserDetailRepository);
    });
  });

  group('Delete user use case should return valid exception', () {
    test('Should return exception if repository returns exception', () async {
      when(mockUserDetailRepository.deleteUser(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final result = await deleteUser(Params(user: tUserA));

      expect(result, Left(CacheFailure()));
      verify(mockUserDetailRepository.deleteUser(tUserA));
      verifyNoMoreInteractions(mockUserDetailRepository);
    });
  });
}
