import 'dart:convert';

import 'package:montageapp/features/random_user/domain/entity/user.dart';

class UserListModel {
  final List<User> userList = List<User>();

  List<User> getParsedUserList(Map<String, dynamic> cachedJson) {
    var jsonList = cachedJson['list'] as List;
    jsonList.forEach((element) {
      final User user = _getUserProperty(element);
      userList.add(user);
    });
    return userList;
  }

  User _getUserProperty(Map<String, dynamic> userJson) {
    return User(
      name: userJson['name'],
      email: userJson['email'],
      userName: userJson['userName'],
      password: userJson['password'],
      address: userJson['address'],
      gender: userJson['gender'],
      imgUrl: userJson['imgUrl'],
    );
  }

  String putJsonList(List<User> userList) {
    List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>();
    userList.forEach((element) {
      final userMap = {
        'name': element.name,
        'email': element.email,
        'userName': element.userName,
        'password': element.password,
        'address': element.address,
        'gender': element.gender,
        'imgUrl': element.imgUrl
      };
      listMap.add(userMap);
    });

    final jsonMap = {
      'list': listMap,
    };

    return json.encode(jsonMap);
  }
}
