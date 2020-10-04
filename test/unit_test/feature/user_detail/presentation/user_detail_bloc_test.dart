import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/params.dart';
import 'package:montageapp/features/user_detail/domain/use_case/delete_user.dart';
import 'package:montageapp/features/user_detail/presentation/bloc/user_detail_bloc.dart';

import '../../../core/dataset/test_data.dart';

class MockDeleteUser extends Mock implements DeleteUser {}

class MockUserDetailEvent extends UserDetailEvent {}

class RandomFailure extends Failure {}

void main() {
  UserDetailBloc bloc;
  MockDeleteUser mockDeleteUser;

  setUp(() {
    mockDeleteUser = MockDeleteUser();
    bloc = UserDetailBloc(deleteUser: mockDeleteUser);
  });

  group('Initial test for User Detail Bloc', () {
    test('Initial bloc state should be [Empty]', () {
      expect(bloc.state, equals(Empty()));
    });

    test('Initial equatable props should be as expected for UserDetail', () {
      final mockUserDetailEvent = MockUserDetailEvent();
      expect(mockUserDetailEvent.props, <dynamic>[]);
    });

    test('Initial equatable props should be as expected for DeleteUser', () {
      final deleteUserEvent = DeleteUserEvent(tUserA);
      expect(deleteUserEvent.props[0], tUserA);
    });

    test('Null value for getUser should return a failed assertion', () {
      expect(() => UserDetailBloc(deleteUser: null),
          throwsA(TypeMatcher<AssertionError>()));
    });
  });

  group('State should delete valid user', () {
    test('Bloc should call the DeleteUserEvent use case for UserA', () async {
      when(mockDeleteUser(any)).thenAnswer((_) async => Right(_));
      bloc.add(DeleteUserEvent(tUserA));
      await untilCalled(mockDeleteUser(any));

      verify(mockDeleteUser(Params(user: tUserA)));
    });

    test('DeleteUserEvent should follow [Empty, Deleted] for UserA', () async {
      when(mockDeleteUser(any)).thenAnswer((_) async => Right(_));
      final expected = [Empty(), Deleted()];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(DeleteUserEvent(tUserA));
    });
  });

  group('State should return valid Failure object for Delete User', () {
    test('Cache Failure should return [Error] with valid message', () async {
      when(mockDeleteUser(any)).thenAnswer((_) async => Left(CacheFailure()));
      final expected = [Empty(), Error(message: CACHE_FAILURE_MESSAGE)];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(DeleteUserEvent(tUserA));
    });

    test('RandomFailure should return [Error] with unexpected message',
        () async {
      when(mockDeleteUser(any)).thenAnswer((_) async => Left(RandomFailure()));
      final expected = [Empty(), Error(message: UNEXPECTED_FAILURE_MESSAGE)];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(DeleteUserEvent(tUserA));
    });
  });
}
