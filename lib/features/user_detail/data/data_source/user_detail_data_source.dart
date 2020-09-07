import 'package:meta/meta.dart';
import 'package:montageapp/core/database/database_helper.dart';
import 'package:montageapp/features/random_user/data/model/user_model.dart';

abstract class UserDetailLocalDataSource {
  Future<void> deleteUser(UserModel user);
}

class UserDetailLocalDataSourceImpl implements UserDetailLocalDataSource {
  final DatabaseHelper client;

  UserDetailLocalDataSourceImpl({@required this.client});

  @override
  Future<void> deleteUser(UserModel user) async {
    await client.delete(user.email, user.password);
  }
}
