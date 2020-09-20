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

class NoDataFailure extends Failure {}

const String SERVER_FAILURE_MESSAGE =
    "Something went wrong. There seems to be a server failure. Please try again later.";
const String NETWORK_FAILURE_MESSAGE =
    "Something went wrong. There seems to be a network failure. Please try again later.";
const String CACHE_FAILURE_MESSAGE =
    "Something went wrong. There seems to be a cache failure. Please try again later.";
const String UNEXPECTED_FAILURE_MESSAGE =
    "Something went wrong. There seems to be an unexpected failure. Please try again later.";
const String NO_DATA_FAILURE_MESSAGE =
    "No saved user found. To add a new user, tap on the + button and generate a random user.";
