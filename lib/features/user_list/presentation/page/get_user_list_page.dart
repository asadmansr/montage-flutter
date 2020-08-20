import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/presentation/page/get_user_page.dart';
import 'package:montageapp/features/random_user/presentation/widget/message_display.dart';
import 'package:montageapp/features/user_list/presentation/bloc/user_list_bloc.dart';

import '../../../../injection_container.dart';

class GetUserListPage extends StatelessWidget {
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
                  color: Color.fromRGBO(38, 38, 47, 1.0),
                  child: Column(
                  children: <Widget>[
                    BlocBuilder<UserListBloc, UserListState>(
                        builder: (context, state) {
                          if (state is Loading) {
                            return MessageDisplay(message: state.toString());
                          } else if (state is Loaded) {
                            return MessageDisplay(message: state.toString());
                          } else if (state is Error){
                            return MessageDisplay(message: "");
                            //return MessageDisplay(message: state.toString());
                          } else {
                            BlocProvider.of<UserListBloc>(providerContext).add(
                                GetUserListEvent()
                            );
                            return MessageDisplay(message: state.toString());
                          }
                        }
                    ),
                  ],
                )
              )
          );
        })
    );
  }

  Widget _fab(BuildContext providerContext) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      child: Icon(Icons.add),
      onPressed: () {
        _navigateAndGenerateUser(providerContext);
      },
    );
  }

  _navigateAndGenerateUser(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GetUserPage()),
    );

    final user = result as User;
    print(user.name);
  }
}
