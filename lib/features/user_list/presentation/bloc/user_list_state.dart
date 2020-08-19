part of 'user_list_bloc.dart';

abstract class UserListState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends UserListState {}

class Loading extends UserListState {}

class Loaded extends UserListState {
  final List<User> userList;

  Loaded({@required this.userList});

  @override
  List<Object> get props => [this.userList];
}

class Error extends UserListState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [this.message];
}
