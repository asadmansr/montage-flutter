import 'package:montageapp/features/random_user/domain/entity/user.dart';

abstract class UserListDataSource {
  Future<List<User>> getUserList();
}
