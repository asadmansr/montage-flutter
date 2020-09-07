import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/params.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_detail/domain/use_case/delete_user.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final DeleteUser deleteUser;

  UserDetailBloc({@required DeleteUser deleteUser})
      : assert(deleteUser != null),
        deleteUser = deleteUser,
        super(Empty());

  @override
  Stream<UserDetailState> mapEventToState(
    UserDetailEvent event,
  ) async* {
    if (event is DeleteUserEvent) {
      final deleteResult = await deleteUser(Params(user: event.user));
      yield deleteResult.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (_) => Deleted());
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
