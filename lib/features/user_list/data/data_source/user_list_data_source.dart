import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_list/data/model/user_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserListDataSource {
  Future<List<User>> getUserList();

  Future<void> cacheUserList(List<User> userList);
}

const CACHED_USER_LIST = "MONTAGE_CACHED_USER_LIST";

class UserListDataSourceImpl implements UserListDataSource {
  final SharedPreferences sharedPreferences;
  final UserListModel userListModel = UserListModel();

  UserListDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<User>> getUserList() {
    final cachedString = sharedPreferences.getString(CACHED_USER_LIST);
    if (cachedString != null) {
      return Future.value(
          userListModel.getParsedUserList(json.decode(cachedString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserList(List<User> userList) {
    return sharedPreferences.setString(
        CACHED_USER_LIST, userListModel.putJsonList(userList));
  }
}
