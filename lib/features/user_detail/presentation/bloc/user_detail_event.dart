part of 'user_detail_bloc.dart';

@immutable
abstract class UserDetailEvent extends Equatable {
  final List properties;

  UserDetailEvent([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => this.properties;
}

class DeleteUserEvent extends UserDetailEvent {
  final User user;

  DeleteUserEvent(this.user);

  @override
  List<Object> get props => [this.user];
}
