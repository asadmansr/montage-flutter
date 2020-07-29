import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';
import 'package:montageapp/features/random_user/presentation/widget/empty_display.dart';
import 'package:montageapp/features/random_user/presentation/widget/loading_display.dart';
import 'package:montageapp/features/random_user/presentation/widget/message_display.dart';
import 'package:montageapp/features/random_user/presentation/widget/generate_user_control.dart';
import 'package:montageapp/features/random_user/presentation/widget/generate_user_display.dart';

import '../../../../injection_container.dart';

class GetUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return LoadingDisplay();
                    } else if (state is Loaded) {
                      return GenerateUserDisplay(user: state.user);
                    } else if (state is Error){
                      return MessageDisplay(message: state.message);
                    } else {
                      return EmptyDisplay();
                    }
                  }
              ),
              new GenerateUserControl()
            ],
          )
        )
    );
  }
}
