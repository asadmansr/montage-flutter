import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:montageapp/core/error/failure.dart';
import 'package:montageapp/core/use_case/no_params.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_list/domain/use_case/get_user_list.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUserList getUserList;

  UserListBloc({@required GetUserList userList})
      : assert(userList != null),
        getUserList = userList,
        super(Empty());

  @override
  Stream<UserListState> mapEventToState(
    UserListEvent event,
  ) async* {
    if (event is GetUserListEvent) {
      yield Loading();
      final userListResult = await getUserList(NoParams());
      yield userListResult.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (userList) => Loaded(userList: userList));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case NoDataFailure:
        return NO_DATA_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
