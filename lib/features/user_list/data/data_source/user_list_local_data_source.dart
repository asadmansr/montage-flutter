import 'package:meta/meta.dart';
import 'package:montageapp/core/database/database_helper.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

abstract class UserListLocalDataSource {
  Future<List<User>> getUserList();
}

class UserListLocalDataSourceImpl implements UserListLocalDataSource {
  final DatabaseHelper client;

  UserListLocalDataSourceImpl({@required this.client});

  @override
  Future<List<User>> getUserList() async {
    final userList = List<User>();
    List<Map<String, dynamic>> allRows;

    try {
      allRows = await client.queryAllRows();
    } catch (_) {
      throw CacheException();
    }

    allRows.forEach((row) {
      final user = User(
          name: row.values.elementAt(1),
          email: row.values.elementAt(2),
          userName: row.values.elementAt(3),
          password: row.values.elementAt(4),
          address: row.values.elementAt(5),
          gender: row.values.elementAt(6),
          imgUrl: row.values.elementAt(7));
      userList.add(user);
    });

    if (userList.isEmpty) {
      throw NoDataException();
    } else {
      return Future.value(userList);
    }
  }
}
