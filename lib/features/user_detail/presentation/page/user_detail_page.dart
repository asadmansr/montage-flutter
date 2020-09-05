import 'package:flutter/material.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_detail/presentation/widget/generate_user_detail.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.backgroundColor,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.delete), onPressed: () {})
          ],
        ),
        body: GenerateUserDetailPage(user: user));
  }
}
