import 'dart:math';

import 'package:meta/meta.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class UserModel extends User {
  UserModel(
      {@required String name,
      @required String email,
      @required String userName,
      @required String password,
      @required String address,
      @required String gender,
      @required String imgUrl})
      : super(
            name: name,
            email: email,
            userName: userName,
            password: password,
            address: address,
            gender: gender,
            imgUrl: imgUrl);

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

    final String gender = "${_jsonObject['gender']}";
    final List _assetsUrl = [
      [
        "assets/man_1.png",
        "assets/man_2.png",
        "assets/man_3.png",
        "assets/man_4.png",
        "assets/man_5.png",
        "assets/man_6.png",
        "assets/man_7.png"
      ],
      [
        "assets/woman_1.png",
        "assets/woman_2.png",
        "assets/woman_3.png",
        "assets/woman_4.png",
        "assets/woman_5.png",
        "assets/woman_6.png",
        "assets/woman_7.png"
      ],
    ];

    String imgUrl = (gender == "male") ?
    _assetsUrl[0][Random().nextInt(7)] :
    _assetsUrl[1][Random().nextInt(7)];

    return UserModel(
        name: "${_nameObject['first']} ${_nameObject['last']}",
        email: "${_jsonObject['email']}",
        userName: "${_loginObject['username']}",
        password: "${_loginObject['password']}",
        address: address,
        gender: gender,
        imgUrl: imgUrl);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'userName': userName,
      'password': password,
      'address': address,
      'gender': gender,
      'imgUrl': imgUrl
    };
  }
}
