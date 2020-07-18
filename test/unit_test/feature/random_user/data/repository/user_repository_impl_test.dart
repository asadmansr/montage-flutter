
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/network/network_info.dart';
import 'package:montageapp/features/random_user/data/data_source/user_remote_data_source.dart';
import 'package:montageapp/features/random_user/data/model/user_model.dart';
import 'package:montageapp/features/random_user/data/repository/user_repository_impl.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  UserRepositoryImpl userRepository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    userRepository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  final tMaleUserModel = UserModel(
      name: "Frederik Stenstad",
      email: "frederik.stenstad@example.com",
      userName: "blueswan657",
      password: "steph",
      address: "2391 Armauer Hansens gate, Hyggen, Møre og Romsdal, Norway");

  final tFemaleUserModel = UserModel(
      name: "Saadia Droste",
      email: "saadia.droste@example.com",
      userName: "tinypeacock811",
      password: "1960",
      address: "9548 De Priorij, Greonterp, Noord-Brabant, Netherlands");

  final User tMaleUser = tMaleUserModel;
  final User tFemaleUser = tFemaleUserModel;

  group('repository should return valid user or failure when online', () {
    test('should call networkInfo when network is available', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      userRepository.getUser();
      verify(mockNetworkInfo.isConnected);
    });

    test('should return valid male user when server response is success', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getUser()).thenAnswer((_) async => tMaleUserModel);

      final result = await userRepository.getUser();

      verify(mockRemoteDataSource.getUser());
      verify(mockNetworkInfo.isConnected);
      expect(result, equals(Right(tMaleUser)));
    });

    test('should return valid female user when server response is success', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getUser()).thenAnswer((_) async => tFemaleUserModel);

      final result = await userRepository.getUser();

      verify(mockRemoteDataSource.getUser());
      verify(mockNetworkInfo.isConnected);
      expect(result, equals(Right(tFemaleUser)));
    });

    test('should return ServerFailure when server response is failure', () async {
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

    test('should throw NoNetworkFailure when no network is available', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await userRepository.getUser();

      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, Left(NoNetworkFailure()));
    });
  });
}
