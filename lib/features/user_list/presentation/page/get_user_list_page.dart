import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/presentation/page/get_user_page.dart';
import 'package:montageapp/core/widgets/empty_display.dart';
import 'package:montageapp/core/widgets/loading_display.dart';
import 'package:montageapp/features/user_list/presentation/bloc/user_list_bloc.dart';
import 'package:montageapp/features/user_list/presentation/widget/generate_user_list.dart';

import '../../../../injection_container.dart';

class GetUserListPage extends StatefulWidget {
  @override
  _GetUserListPageState createState() => _GetUserListPageState();
}

class _GetUserListPageState extends State<GetUserListPage> {
  List<User> userList = List<User>();

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<UserListBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserListBloc>(),
        child: Builder(builder: (providerContext) {
          return Scaffold(
              floatingActionButton: _fab(providerContext),
              body: Container(
                  color: Color.backgroundColor,
                  child: Column(
                    children: <Widget>[
                      BlocBuilder<UserListBloc, UserListState>(
                          builder: (context, state) {
                        if (state is Loading) {
                          return LoadingDisplay();
                        } else if (state is Loaded) {
                          userList = state.userList;
                          return GenerateUserList(userList: userList);
                        } else if (state is Error) {
                          return EmptyDisplay();
                        } else if (state is Refresh) {
                          _dispatchGetListEvent(providerContext);
                          return EmptyDisplay();
                        } else {
                          _dispatchGetListEvent(providerContext);
                          return EmptyDisplay();
                        }
                      }),
                    ],
                  )
              )
          );
        })
    );
  }

  void _dispatchGetListEvent(BuildContext providerContext) {
    BlocProvider.of<UserListBloc>(providerContext).add(GetUserListEvent());
  }

  Widget _fab(BuildContext providerContext) {
    return FloatingActionButton(
      backgroundColor: Color.greenColor,
      child: Icon(Icons.add),
      onPressed: () {
        _navigateAndGenerateUser(providerContext);
      },
    );
  }

  void _navigateAndGenerateUser(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GetUserPage()),
    );

    final user = result as User;

    if (user != null) {
      userList.add(user);
      BlocProvider.of<UserListBloc>(context).add(SaveUserListEvent(userList));
    }
  }
}
