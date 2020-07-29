import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';

class GenerateUserControl extends StatefulWidget {
  const GenerateUserControl({Key key,}): super(key: key);

  @override
  _GenerateUserControlState createState() => _GenerateUserControlState();
}

class _GenerateUserControlState extends State<GenerateUserControl> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 48),
        RawMaterialButton(
          shape: CircleBorder(),
          fillColor: Colors.green,
          elevation: 4.0,
          padding: EdgeInsets.all(14.0),
          child: Icon(
            Icons.refresh,
            size: 24.0,
            color: Colors.white,
          ),
          onPressed: dispatchGetUser,
        ),
        SizedBox(width: 16)
      ],
    );
  }

  void dispatchGetUser() {
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
  }
}
