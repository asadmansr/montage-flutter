part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends UserState {}

class Loading extends UserState {}

class Loaded extends UserState {
  final User user;

  Loaded({@required this.user});

  @override
  List<Object> get props => [this.user];
}

class Error extends UserState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [this.message];
}

class Saved extends UserState {}
