import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;
import 'package:montageapp/core/widgets/empty_display.dart';
import 'package:montageapp/core/widgets/loading_display.dart';
import 'package:montageapp/core/widgets/message_display.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';
import 'package:montageapp/features/random_user/presentation/widget/generate_user_control.dart';
import 'package:montageapp/features/random_user/presentation/widget/generate_user_display.dart';

import '../../../../injection_container.dart';

class GetUserPage extends StatefulWidget {
  @override
  _GetUserPageState createState() => _GetUserPageState();
}

class _GetUserPageState extends State<GetUserPage> {
  User user;

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<UserBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>(),
      child: Builder(
        builder: (providerContext) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.backgroundColor,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      _dispatchSaveUser(providerContext);
                    })
              ],
            ),
            body: SizedBox.expand(
              child: Container(
                color: Color.backgroundColor,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  child: Container(
                    color: Color.backgroundColor,
                    child: Column(
                      children: <Widget>[
                        BlocListener<UserBloc, UserState>(
                          listener: (BuildContext context, UserState state) {
                            if (state is Saved) {
                              _navigateBack();
                            }
                          },
                          child: BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                            if (state is Loading) {
                              return LoadingDisplay();
                            } else if (state is Loaded) {
                              user = state.user;
                              return GenerateUserDisplay(user: state.user);
                            } else if (state is Error) {
                              return MessageDisplay(message: state.message);
                            } else {
                              _dispatchGetUser(providerContext);
                            }
                            return EmptyDisplay();
                          }),
                        ),
                        new GenerateUserControl()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _dispatchGetUser(BuildContext providerContext) {
    BlocProvider.of<UserBloc>(providerContext).add(GetUserEvent());
  }

  void _dispatchSaveUser(BuildContext providerContext) {
    BlocProvider.of<UserBloc>(providerContext).add(SaveUserEvent(user));
  }

  void _navigateBack() {
    Navigator.pop(context, true);
  }
}
