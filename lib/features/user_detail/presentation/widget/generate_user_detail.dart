import 'package:flutter/material.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class GenerateUserDetailPage extends StatelessWidget {
  final User user;

  const GenerateUserDetailPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.backgroundColor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 48,
            ),
            CircleAvatar(
                backgroundColor: Color.backgroundAccentColor,
                radius: 96,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image(
                    image: AssetImage(this.user.imgUrl),
                  ),
                )),
            SizedBox(
              height: 16,
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
          ],
        )
    );
  }
}
