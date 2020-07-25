import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/no_params.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/domain/use_case/get_user.dart';
import 'package:montageapp/features/random_user/presentation/user_bloc.dart';

class MockGetUser extends Mock implements GetUser {}

class RandomFailure extends Failure {}

void main() {
  UserBloc bloc;
  MockGetUser mockGetUser;

  setUp(() {
    mockGetUser = MockGetUser();
    bloc = UserBloc(user: mockGetUser);
  });

  test('Initial bloc state should be [Empty]', () {
    expect(bloc.state, equals(Empty()));
  });

  group('State should return valid User object', () {
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

    test('GetUserEvent should follow [Empty, Loading, Loaded] for UserA', () async {
      when(mockGetUser(any)).thenAnswer((_) async => Right(tUserA));
      final expected = [Empty(), Loading(), Loaded(user: tUserA)];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetUserEvent());
    });

    test('GetUserEvent should follow [Empty, Loading, Loaded] for UserB', () async {
      when(mockGetUser(any)).thenAnswer((_) async => Right(tUserB));
      final expected = [Empty(), Loading(), Loaded(user: tUserB)];

      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetUserEvent());
    });
  });

  group('State should return valid Failure object', () {
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

    test('RandomFailure should return [Error] with unexpected message', () async {
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
}
