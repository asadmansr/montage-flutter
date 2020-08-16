import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/params.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_list/domain/repository/user_list_repository.dart';
import 'package:montageapp/features/user_list/domain/use_case/save_user_list.dart';

import '../../../../core/dataset/test_data.dart';

class MockUserListRepository extends Mock implements UserListRepository {}

void main() {
  List<User> userList;
  MockUserListRepository mockUserListRepository;
  SaveUserList saveUserList;

  setUp(() {
    mockUserListRepository = MockUserListRepository();
    saveUserList = SaveUserList(mockUserListRepository);
    userList = [tUserA, tUserB];
  });

  group('Should perform valid operations in repository', () {
    test('Should perform validation operation when saving the list', () async {
      when(mockUserListRepository.saveUserList(any))
          .thenAnswer((_) async => Right(null));

      await saveUserList(Params(list: userList));

      verify(mockUserListRepository.saveUserList(userList));
      verifyNoMoreInteractions(mockUserListRepository);
    });
  });

  group('Should perform valid exception in repository', () {
    test('Should return CacheFailure if unable to save', () async {
      when(mockUserListRepository.saveUserList(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final result = await saveUserList(Params(list: userList));

      expect(result, Left(CacheFailure()));
      verify(mockUserListRepository.saveUserList(userList));
      verifyNoMoreInteractions(mockUserListRepository);
    });
  });
}
