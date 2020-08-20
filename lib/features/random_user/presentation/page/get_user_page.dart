import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';
import 'package:montageapp/features/random_user/presentation/widget/empty_display.dart';
import 'package:montageapp/features/random_user/presentation/widget/generate_user_control.dart';
import 'package:montageapp/features/random_user/presentation/widget/generate_user_display.dart';
import 'package:montageapp/features/random_user/presentation/widget/loading_display.dart';
import 'package:montageapp/features/random_user/presentation/widget/message_display.dart';

import '../../../../injection_container.dart';

class GetUserPage extends StatefulWidget {
  @override
  _GetUserPageState createState() => _GetUserPageState();
}

class _GetUserPageState extends State<GetUserPage> {
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(38, 38, 47, 1.0),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _saveAndNavigateBack()
              )
        ],
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<UserBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserBloc>(),
        child: Container(
            color: Color.fromRGBO(38, 38, 47, 1.0),
            child: Column(
              children: <Widget>[
                BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  if (state is Loading) {
                    return LoadingDisplay();
                  } else if (state is Loaded) {
                    user = state.user;
                    return GenerateUserDisplay(user: state.user);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  } else {
                    _dispatchGetUser(context);
                    return EmptyDisplay();
                  }
                }),
                Spacer(),
                new GenerateUserControl()
              ],
            )
        )
    );
  }

  void _dispatchGetUser(BuildContext providerContext) {
    BlocProvider.of<UserBloc>(providerContext).add(GetUserEvent());
  }

  void _saveAndNavigateBack(){
    Navigator.pop(context, user);
  }
}
