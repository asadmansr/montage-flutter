import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/database/database_helper.dart';
import 'package:montageapp/features/random_user/data/data_source/user_local_data_source.dart';

import '../../../../core/dataset/test_data.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  UserLocalDataSourceImpl userLocalDataSourceImpl;
  MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    userLocalDataSourceImpl =
        UserLocalDataSourceImpl(client: mockDatabaseHelper);
  });

  group('Should return valid operation for user local data source', () {
    Map<String, dynamic> rowUserA = {
      DatabaseHelper.colName: tMaleUserModel.name,
      DatabaseHelper.colEmail: tMaleUserModel.email,
      DatabaseHelper.colUserName: tMaleUserModel.userName,
      DatabaseHelper.colPassword: tMaleUserModel.password,
      DatabaseHelper.colAddress: tMaleUserModel.address,
      DatabaseHelper.colGender: tMaleUserModel.gender,
      DatabaseHelper.colImgUrl: tMaleUserModel.imgUrl
    };

    test('Should return valid operation when saving a new user', () async {
      when(mockDatabaseHelper.insert(any))
          .thenAnswer((_) async => Future.value(1));

      await userLocalDataSourceImpl.saveUser(tMaleUserModel);
      verify(mockDatabaseHelper.insert(rowUserA));
    });
  });
}
