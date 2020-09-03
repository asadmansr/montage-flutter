import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/network/network_info.dart';
import 'package:montageapp/features/random_user/data/data_source/user_local_data_source.dart';
import 'package:montageapp/features/random_user/data/data_source/user_remote_data_source.dart';
import 'package:montageapp/features/random_user/data/repository/user_repository_impl.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

import '../../../../core/dataset/test_data.dart';
import '../../../../core/helper/user_assertion.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  UserRepositoryImpl userRepository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;
  UserAssertions userAssertions;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    userAssertions = UserAssertions();

    userRepository = UserRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo,
        localDataSource: mockLocalDataSource);
  });

  final User tMaleUser = tMaleUserModel;
  final User tFemaleUser = tFemaleUserModel;

  group('repository should return valid user or failure when online', () {
    test('should call networkInfo when network is available', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      userRepository.getUser();
      verify(mockNetworkInfo.isConnected);
    });

    test('should return valid male user when server response is success',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getUser())
          .thenAnswer((_) async => tMaleUserModel);

      final result = await userRepository.getUser();

      verify(mockRemoteDataSource.getUser());
      verify(mockNetworkInfo.isConnected);
      expect(result, equals(Right(tMaleUser)));
      final actual = userAssertions.assertUserModel(
          result.getOrElse(null), tMaleUserModel);
      expect(actual, true);
    });

    test('should return valid female user when server response is success',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getUser())
          .thenAnswer((_) async => tFemaleUserModel);

      final result = await userRepository.getUser();

      verify(mockRemoteDataSource.getUser());
      verify(mockNetworkInfo.isConnected);
      expect(result, equals(Right(tFemaleUser)));
      final actual = userAssertions.assertUserModel(
          result.getOrElse(null), tFemaleUserModel);
      expect(actual, true);
    });

    test('should return ServerFailure when server response is failure',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getUser()).thenThrow(ServerException());

      final result = await userRepository.getUser();

      verify(mockRemoteDataSource.getUser());
      verify(mockNetworkInfo.isConnected);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('repository should return valid failure when offline', () {
    test('should call networkInfo when no network is available', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      userRepository.getUser();
      verify(mockNetworkInfo.isConnected);
    });

    test('should throw NoNetworkFailure when no network is available',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await userRepository.getUser();

      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, Left(NoNetworkFailure()));
    });
  });

  group('should be able to save a new user', () {
    test('should call save user in local data source when saving new user',
        () async {
      when(mockLocalDataSource.saveUser(any)).thenAnswer((_) async => null);
      userRepository.saveUser(tMaleUserModel);
      verify(mockLocalDataSource.saveUser(tMaleUserModel));
    });

    test('should return valid cache failure when cache exception is thrown',
        () async {
      when(mockLocalDataSource.saveUser(any)).thenThrow(CacheException());
      final result = await userRepository.saveUser(tMaleUserModel);
      verify(mockLocalDataSource.saveUser(tMaleUserModel));
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
