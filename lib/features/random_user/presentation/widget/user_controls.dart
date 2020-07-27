import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';

class UserControls extends StatefulWidget {
  const UserControls({
    Key key,
  }): super(key: key);

  @override
  _UserControlsState createState() => _UserControlsState();
}

class _UserControlsState extends State<UserControls> {

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 10,),
      Row(children: <Widget>[
        Expanded(child: RaisedButton(
            child: Text('Search'),
            color: Theme.of(context).accentColor,
            textTheme: ButtonTextTheme.primary,
            onPressed: dispatchGetUser
        )),
        SizedBox(width: 10,)
      ],)
    ],);
  }

  void dispatchGetUser() {
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
  }
}