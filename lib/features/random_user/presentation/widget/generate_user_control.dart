import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';

class GenerateUserControl extends StatefulWidget {
  const GenerateUserControl({
    Key key,
  }) : super(key: key);

  @override
  _GenerateUserControlState createState() => _GenerateUserControlState();
}

class _GenerateUserControlState extends State<GenerateUserControl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.backgroundColor,
      child: Column(
        children: <Widget>[
          SizedBox(height: 14),
          RawMaterialButton(
            shape: CircleBorder(),
            fillColor: Color.greenColor,
            elevation: 4.0,
            padding: EdgeInsets.all(14.0),
            child: Icon(
              Icons.refresh,
              size: 24.0,
              color: Color.whiteColor,
            ),
            onPressed: _dispatchGetUser,
          ),
          SizedBox(height: 24)
        ],
      ),
    );
  }

  void _dispatchGetUser() {
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
  }
}
