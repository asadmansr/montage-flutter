import 'package:flutter/material.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class GenerateUserDisplay extends StatelessWidget {
  final User user;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController addressController;

  const GenerateUserDisplay({
    Key key,
    @required this.user,
    @required this.nameController,
    @required this.emailController,
    @required this.usernameController,
    @required this.passwordController,
    @required this.addressController,
  }) : super(key: key);

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
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Color.whiteColor),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.formBorderColor))),
              style: TextStyle(color: Color.whiteColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color.whiteColor),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.formBorderColor))),
              style: TextStyle(color: Color.whiteColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Color.whiteColor),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.formBorderColor))),
              style: TextStyle(color: Color.whiteColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color.whiteColor),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.formBorderColor))),
              style: TextStyle(color: Color.whiteColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Color.whiteColor),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.formBorderColor))),
              style: TextStyle(color: Color.whiteColor),
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
