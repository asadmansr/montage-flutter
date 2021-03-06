import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String userName;
  final String password;
  final String address;
  final String gender;
  final String imgUrl;

  User(
      {@required this.name,
      @required this.email,
      @required this.userName,
      @required this.password,
      @required this.address,
      @required this.gender,
      @required this.imgUrl});

  @override
  List<Object> get props => [name, email, userName, password, address, gender, imgUrl];
}
