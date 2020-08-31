import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/no_params.dart';
import 'package:montageapp/core/use_case/params.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/domain/use_case/get_user.dart';
import 'package:montageapp/features/random_user/domain/use_case/save_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;
  final SaveUser saveUser;

  UserBloc({@required GetUser getUser, @required SaveUser saveUser})
      : assert(getUser != null),
        assert(saveUser != null),
        getUser = getUser,
        saveUser = saveUser,
        super(Empty());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUserEvent) {
      yield Loading();
      final userResult = await getUser(NoParams());
      yield userResult.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (user) => Loaded(user: user));
    } else if (event is SaveUserEvent) {
      final saveResult = await saveUser(Params(user: event.user));
      yield saveResult.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (_) => Saved());
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NoNetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
