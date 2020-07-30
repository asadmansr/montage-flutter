import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:montageapp/core/error/exception.dart';
import 'package:montageapp/features/random_user/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final _url = 'https://randomuser.me/api/';
  final _param = "?nat=au,br,ca,ch,de,dk,fi,fr,gb,ei,nl,nz,us";
  final _headers = {'Content-Type': 'application/json'};
  final http.Client client;

  UserRemoteDataSourceImpl({@required this.client});

  @override
  Future<UserModel> getUser() {
    return _getUserFromUrl();
  }

  Future<UserModel> _getUserFromUrl() async {
    final response = await client.get(_url + _param, headers: _headers);
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
