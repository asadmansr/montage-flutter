import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/no_params.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_list/domain/repository/user_list_repository.dart';
import 'package:montageapp/features/user_list/domain/use_case/get_user_list.dart';

import '../../../../core/dataset/test_data.dart';

class MockUserListRepository extends Mock implements UserListRepository {}

void main() {
  MockUserListRepository mockUserListRepository;
  GetUserList getUserList;
  List<User> userList;

  setUp(() {
    mockUserListRepository = MockUserListRepository();
    getUserList = GetUserList(mockUserListRepository);
    userList = [tUserA, tUserB];
  });

  group(' ', () {
    test('', () async {
      when(mockUserListRepository.getUserList())
          .thenAnswer((_) async => Right(userList));

      final result = await getUserList(NoParams());
      final actual = result.getOrElse(null);

      expect(actual.length, 2);
      expect(actual[0], tUserA);
      expect(actual[1], tUserB);
      verify(mockUserListRepository.getUserList());
      verifyNoMoreInteractions(mockUserListRepository);
    });
  });

  group(' ', () {
    test('', () async {
      when(mockUserListRepository.getUserList())
          .thenAnswer((_) async => Left(CacheFailure()));

      final result = await getUserList(NoParams());

      expect(result, Left(CacheFailure()));
      verify(mockUserListRepository.getUserList());
      verifyNoMoreInteractions(mockUserListRepository);
    });
  });
}
