import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_detail/presentation/bloc/user_detail_bloc.dart';
import 'package:montageapp/features/user_detail/presentation/widget/generate_user_detail.dart';

import '../../../../injection_container.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<UserDetailBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserDetailBloc>(),
      child: Builder(
        builder: (providerContext) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.backgroundColor,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _dispatchDeleteUser(providerContext);
                    })
              ],
            ),
            body: Container(
              color: Color.backgroundColor,
              child: Column(
                children: <Widget>[
                  BlocListener<UserDetailBloc, UserDetailState>(
                    listener: (BuildContext context, UserDetailState state) {
                      if (state is Deleted) {
                        _navigateBack(context);
                      }
                    },
                    child: BlocBuilder<UserDetailBloc, UserDetailState>(
                      builder: (context, state) {
                        return GenerateUserDetailPage(user: user);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _dispatchDeleteUser(BuildContext providerContext) {
    BlocProvider.of<UserDetailBloc>(providerContext).add(DeleteUserEvent(user));
  }

  void _navigateBack(BuildContext context) {
    Navigator.pop(context, true);
  }
}
