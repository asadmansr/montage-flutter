part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  final List properties;
  UserEvent([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => this.properties;
}

class GetUserEvent extends UserEvent {}
