import 'package:meta/meta.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class UserModel extends User {
  UserModel(
      {@required String name,
      @required String email,
      @required String userName,
      @required String password,
      @required String address})
      : super(
            name: name,
            email: email,
            userName: userName,
            password: password,
            address: address);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> _jsonObject = json['results'][0];
    final Map<String, dynamic> _nameObject = _jsonObject['name'];
    final Map<String, dynamic> _loginObject = _jsonObject['login'];
    final Map<String, dynamic> _locationObject = _jsonObject['location'];

    final String address = "${_locationObject['street']['number'].toString()}" +
        " " + "${_locationObject['street']['name']}," +
        " " + "${_locationObject['city']}," +
        " " + "${_locationObject['state']}," +
        " " + "${_locationObject['country']}";

    return UserModel(
        name: "${_nameObject['first']} ${_nameObject['last']}",
        email: "${_jsonObject['email']}",
        userName: "${_loginObject['username']}",
        password: "${_loginObject['password']}",
        address: address);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'userName': userName,
      'password': password,
      'address': address
    };
  }
}
