import 'package:flutter/material.dart';

class EmptyDisplay extends StatelessWidget {
  const EmptyDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Container(),
    );
  }
}
