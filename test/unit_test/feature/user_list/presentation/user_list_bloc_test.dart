import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/no_params.dart';
import 'package:montageapp/features/user_list/domain/use_case/get_user_list.dart';
import 'package:montageapp/features/user_list/presentation/bloc/user_list_bloc.dart';

import '../../../core/dataset/test_data.dart';

class MockGetUserList extends Mock implements GetUserList {}

class MockUserListEvent extends UserListEvent {}

class RandomFailure extends Failure {}

void main() {
  UserListBloc bloc;
  MockGetUserList mockGetUserList;

  setUp(() {
    mockGetUserList = MockGetUserList();
    bloc = UserListBloc(userList: mockGetUserList);
  });

  group('Initial test for User Detail Bloc', () {
    test('Initial bloc state should be [Empty]', () {
      expect(bloc.state, equals(Empty()));
    });

    test('Initial equatable props should be as expected for UserDetail', () {
      final mockUserDetailEvent = MockUserListEvent();
      expect(mockUserDetailEvent.props, <dynamic>[]);
    });

    test('Initial equatable props should be as expected for DeleteUser', () {
      final userListEvent = GetUserListEvent();
      expect(userListEvent.props, <dynamic>[]);
    });

    test('Null value for getUser should return a failed assertion', () {
      expect(() => UserListBloc(userList: null),
          throwsA(TypeMatcher<AssertionError>()));
    });
  });

  group('State should delete valid user', () {
    test('Bloc should call the DeleteUserEvent use case for UserA', () async {
      when(mockGetUserList(any)).thenAnswer((_) async => Right([tUserA]));
      bloc.add(GetUserListEvent());
      await untilCalled(mockGetUserList(any));

      verify(mockGetUserList(NoParams()));
    });

    test('DeleteUserEvent should follow [Empty, Deleted] for UserA', () async {
      when(mockGetUserList(any)).thenAnswer((_) async => Right([tUserA]));
      final expected = [
        Empty(),
        Loading(),
        Loaded(userList: [tUserA])
      ];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetUserListEvent());
    });
  });

  group('State should return valid Failure object for Delete User', () {
    test('Cache Failure should return [Error] with valid message', () async {
      when(mockGetUserList(any)).thenAnswer((_) async => Left(CacheFailure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE)
      ];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetUserListEvent());
    });

    test('RandomFailure should return [Error] with unexpected message',
        () async {
      when(mockGetUserList(any)).thenAnswer((_) async => Left(RandomFailure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: UNEXPECTED_FAILURE_MESSAGE)
      ];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetUserListEvent());
    });
  });
}
