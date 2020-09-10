import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/core/database/database_helper.dart';
import 'package:montageapp/features/user_detail/data/data_source/user_detail_data_source.dart';

import '../../../../core/dataset/test_data.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  UserDetailLocalDataSourceImpl userDetailLocalDataSourceImpl;
  MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    userDetailLocalDataSourceImpl =
        UserDetailLocalDataSourceImpl(client: mockDatabaseHelper);
  });

  group('Should return valid operation for user local data source', () {
    test('Should return valid operation when saving a new user', () async {
      when(mockDatabaseHelper.delete(any, any))
          .thenAnswer((_) async => Future.value(1));

      await userDetailLocalDataSourceImpl.deleteUser(tMaleUserModel);
      verify(mockDatabaseHelper.delete(
          tMaleUserModel.email, tMaleUserModel.password));
    });
  });
}
