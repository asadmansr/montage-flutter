import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties = const <dynamic>[];

  Failure();

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {}

class NoNetworkFailure extends Failure {}

class CacheFailure extends Failure {}

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String NETWORK_FAILURE_MESSAGE = "Network Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String UNEXPECTED_FAILURE_MESSAGE = "Unexpected Failure";
