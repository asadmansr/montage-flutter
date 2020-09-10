import 'package:meta/meta.dart';
import 'package:montageapp/core/database/database_helper.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

abstract class UserDetailLocalDataSource {
  Future<void> deleteUser(User user);
}

class UserDetailLocalDataSourceImpl implements UserDetailLocalDataSource {
  final DatabaseHelper client;

  UserDetailLocalDataSourceImpl({@required this.client});

  @override
  Future<void> deleteUser(User user) async {
    await client.delete(user.email, user.password);
  }
}
