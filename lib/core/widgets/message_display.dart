import 'package:flutter/material.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(message,
              style: TextStyle(fontSize: 25, color: Color.whiteColor),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
