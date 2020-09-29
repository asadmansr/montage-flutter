import 'package:flutter/material.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class GenerateUserDisplay extends StatelessWidget {
  final User user;

  const GenerateUserDisplay({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.backgroundColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          CircleAvatar(
              backgroundColor: Color.backgroundAccentColor,
              radius: 82,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image(
                  image: AssetImage(this.user.imgUrl),
                ),
              )),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Color.whiteColor),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.formBorderColor))),
              style: TextStyle(color: Color.whiteColor),
              readOnly: true,
              initialValue: this.user.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color.whiteColor),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.formBorderColor))),
              style: TextStyle(color: Color.whiteColor),
              readOnly: true,
              initialValue: this.user.email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Color.whiteColor),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.formBorderColor))),
              style: TextStyle(color: Color.whiteColor),
              readOnly: true,
              initialValue: this.user.userName,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color.whiteColor),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.formBorderColor))),
              style: TextStyle(color: Color.whiteColor),
              readOnly: true,
              initialValue: this.user.password,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Color.whiteColor),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.formBorderColor))),
              style: TextStyle(color: Color.whiteColor),
              readOnly: true,
              initialValue: this.user.address,
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
