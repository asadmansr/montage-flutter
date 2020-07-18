import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties = const <dynamic>[];

  Failure();

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {}

class NoNetworkFailure extends Failure {}
