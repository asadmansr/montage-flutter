part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends UserDetailState {}

class Loading extends UserDetailState {}

class Deleted extends UserDetailState {}

class Error extends UserDetailState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [this.message];
}
