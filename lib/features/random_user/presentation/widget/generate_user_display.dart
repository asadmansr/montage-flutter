import 'dart:math';

import 'package:flutter/material.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class GenerateUserDisplay extends StatelessWidget {
  final User user;

  const GenerateUserDisplay({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(38, 38, 47, 1.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 48,
          ),
          CircleAvatar(
            backgroundColor: Color.fromRGBO(41, 41, 51, 1.0),
            radius: 96,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image(
                image: AssetImage(_getRandomAssetUrl()),
              ),
            )
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
              readOnly: true,
              initialValue: this.user.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
              readOnly: true,
              initialValue: this.user.email,
            ),
          ),
        ],
      )
    );
  }

  String _getRandomAssetUrl() {
    var assetList = [
      "assets/man_1.png",
      "assets/man_2.png",
      "assets/man_3.png",
      "assets/man_4.png",
      "assets/man_5.png",
      "assets/man_6.png",
      "assets/man_7.png",
      "assets/woman_1.png",
      "assets/woman_2.png",
      "assets/woman_3.png",
      "assets/woman_4.png",
      "assets/woman_5.png",
      "assets/woman_6.png",
      "assets/woman_7.png",
    ];

    return assetList[Random().nextInt(14)];
  }
}
