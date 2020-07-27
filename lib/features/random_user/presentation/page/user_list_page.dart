import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';
import 'package:montageapp/features/random_user/presentation/widget/message_display.dart';
import 'package:montageapp/features/random_user/presentation/widget/user_controls.dart';

import '../../../../injection_container.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random User"),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<UserBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<UserBloc, UserState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is Empty) {
                      return MessageDisplay(
                        message: 'Empty',
                      );
                    } else if (state is Loaded) {
                      print(state.user);
                      return MessageDisplay(
                        message: "Name: ${state.user.name},\n" +
                            "UserName: ${state.user.userName},\n" +
                            "Email: ${state.user.email},\n" +
                            "Password: ${state.user.password},\n" +
                            "Address: ${state.user.address}",
                      );
                    } else if (state is Loading) {
                      return MessageDisplay(
                        message: 'loading',
                      );
                    } else if (state is Error) {
                      return MessageDisplay(
                        message: state.message,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                new UserControls()
              ],
            ),
          ),
        ));
  }
}
