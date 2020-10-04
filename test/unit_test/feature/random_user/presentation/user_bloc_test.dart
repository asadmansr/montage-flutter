import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/no_params.dart';
import 'package:montageapp/core/use_case/params.dart';
import 'package:montageapp/features/random_user/domain/use_case/get_user.dart';
import 'package:montageapp/features/random_user/domain/use_case/save_user.dart';
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';

import '../../../core/dataset/test_data.dart';

class MockGetUser extends Mock implements GetUser {}

class MockSaveUser extends Mock implements SaveUser {}

class RandomFailure extends Failure {}

void main() {
  UserBloc bloc;
  MockGetUser mockGetUser;
  MockSaveUser mockSaveUser;

  setUp(() {
    mockGetUser = MockGetUser();
    mockSaveUser = MockSaveUser();
    bloc = UserBloc(getUser: mockGetUser, saveUser: mockSaveUser);
  });

  group('Initial test for User Bloc', () {
    test('Initial bloc state should be [Empty]', () {
      expect(bloc.state, equals(Empty()));
    });

    test('Initial equatable props value should be as expected for SaveUser',
        () {
      final saveUserEvent = SaveUserEvent(tUserA);
      expect(saveUserEvent.props[0], tUserA);
    });

    test('Initial equatable props value should be as expected for GetUser', () {
      final getUserEvent = GetUserEvent();
      expect(getUserEvent.props, <dynamic>[]);
    });

    test('Null value for getUser should return a failed assertion', () {
      expect(() => UserBloc(getUser: null, saveUser: mockSaveUser),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('Null value for saveUser should return a failed assertion', () {
      expect(() => UserBloc(getUser: mockGetUser, saveUser: null),
          throwsA(TypeMatcher<AssertionError>()));
    });
  });

  group('State should return valid User object', () {
    test('Bloc should call the GetUser use case for UserA', () async {
      when(mockGetUser(any)).thenAnswer((_) async => Right(tUserA));
      bloc.add(GetUserEvent());
      await untilCalled(mockGetUser(any));

      verify(mockGetUser(NoParams()));
    });

    test('Bloc should call the GetUser use case for UserB', () async {
      when(mockGetUser(any)).thenAnswer((_) async => Right(tUserB));
      bloc.add(GetUserEvent());
      await untilCalled(mockGetUser(any));

      verify(mockGetUser(NoParams()));
    });

    test('GetUserEvent should follow [Empty, Loading, Loaded] for UserA',
        () async {
      when(mockGetUser(any)).thenAnswer((_) async => Right(tUserA));
      final expected = [Empty(), Loading(), Loaded(user: tUserA)];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetUserEvent());
    });

    test('GetUserEvent should follow [Empty, Loading, Loaded] for UserB',
        () async {
      when(mockGetUser(any)).thenAnswer((_) async => Right(tUserB));
      final expected = [Empty(), Loading(), Loaded(user: tUserB)];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetUserEvent());
    });
  });

  group('State should save valid user', () {
    test('Bloc should call the SaveUserEvent use case for UserA', () async {
      when(mockSaveUser(any)).thenAnswer((_) async => Right(_));
      bloc.add(SaveUserEvent(tUserA));
      await untilCalled(mockSaveUser(any));

      verify(mockSaveUser(Params(user: tUserA)));
    });

    test('SaveUserEvent should follow [Empty, Saved] for UserA',
        () async {
      when(mockSaveUser(any)).thenAnswer((_) async => Right(_));
      final expected = [Empty(), Saved()];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(SaveUserEvent(tUserA));
    });
  });

  group('State should return valid Failure object for GetUser', () {
    test('ServerFailure should return [Error] with valid message', () async {
      when(mockGetUser(any)).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetUserEvent());
    });

    test('NetworkFailure should return [Error] with valid message', () async {
      when(mockGetUser(any)).thenAnswer((_) async => Left(NoNetworkFailure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: NETWORK_FAILURE_MESSAGE)
      ];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetUserEvent());
    });

    test('RandomFailure should return [Error] with unexpected message',
        () async {
      when(mockGetUser(any)).thenAnswer((_) async => Left(RandomFailure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: UNEXPECTED_FAILURE_MESSAGE)
      ];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetUserEvent());
    });
  });

  group('State should return valid Failure object for SaveUser', () {
    test('ServerFailure should return [Error] with valid message', () async {
      when(mockSaveUser(any)).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [Empty(), Error(message: SERVER_FAILURE_MESSAGE)];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(SaveUserEvent(tUserA));
    });

    test('NetworkFailure should return [Error] with valid message', () async {
      when(mockSaveUser(any)).thenAnswer((_) async => Left(NoNetworkFailure()));
      final expected = [Empty(), Error(message: NETWORK_FAILURE_MESSAGE)];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(SaveUserEvent(tUserA));
    });

    test('RandomFailure should return [Error] with unexpected message',
        () async {
      when(mockSaveUser(any)).thenAnswer((_) async => Left(RandomFailure()));
      final expected = [Empty(), Error(message: UNEXPECTED_FAILURE_MESSAGE)];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(SaveUserEvent(tUserA));
    });
  });
}
