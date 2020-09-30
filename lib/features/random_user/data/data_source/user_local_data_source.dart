import 'package:meta/meta.dart';
import 'package:montageapp/core/database/database_helper.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(User user);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final DatabaseHelper client;

  UserLocalDataSourceImpl({@required this.client});

  @override
  Future<void> saveUser(User user) async {
    Map<String, dynamic> row = {
      DatabaseHelper.colName: user.name,
      DatabaseHelper.colEmail: user.email,
      DatabaseHelper.colUserName: user.userName,
      DatabaseHelper.colPassword: user.password,
      DatabaseHelper.colAddress: user.address,
      DatabaseHelper.colGender: user.gender,
      DatabaseHelper.colImgUrl: user.imgUrl
    };

    await client.insert(row);
  }
}
