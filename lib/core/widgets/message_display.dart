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
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Text(message,
                style: TextStyle(
                    fontSize: 18,
                    color: Color.whiteColor,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
