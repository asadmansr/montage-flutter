part of 'user_list_bloc.dart';

@immutable
abstract class UserListEvent extends Equatable {
  final List properties;

  UserListEvent([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => this.properties;
}

class GetUserListEvent extends UserListEvent {}
