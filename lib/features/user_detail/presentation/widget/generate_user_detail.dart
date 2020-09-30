import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class GenerateUserDetailPage extends StatelessWidget {
  final User user;

  const GenerateUserDetailPage({Key key, @required this.user})
      : super(key: key);

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
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 0.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Color.whiteColor),
                        enabledBorder: new UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.formBorderColor))),
                    style: TextStyle(color: Color.whiteColor),
                    readOnly: true,
                    initialValue: this.user.name,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _copyToClipboard(context, "Name", this.user.name);
                },
                child: Icon(
                  Icons.content_copy,
                  color: Color.whiteColor,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 0.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Color.whiteColor),
                        enabledBorder: new UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.formBorderColor))),
                    style: TextStyle(color: Color.whiteColor),
                    readOnly: true,
                    initialValue: this.user.email,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _copyToClipboard(context, "Email", this.user.email);
                },
                child: Icon(
                  Icons.content_copy,
                  color: Color.whiteColor,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 0.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Color.whiteColor),
                        enabledBorder: new UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.formBorderColor))),
                    style: TextStyle(color: Color.whiteColor),
                    readOnly: true,
                    initialValue: this.user.userName,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _copyToClipboard(context, "Username", this.user.userName);
                },
                child: Icon(
                  Icons.content_copy,
                  color: Color.whiteColor,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 0.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color.whiteColor),
                        enabledBorder: new UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.formBorderColor))),
                    style: TextStyle(color: Color.whiteColor),
                    readOnly: true,
                    initialValue: this.user.password,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _copyToClipboard(context, "Password", this.user.password);
                },
                child: Icon(
                  Icons.content_copy,
                  color: Color.whiteColor,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 0.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(color: Color.whiteColor),
                        enabledBorder: new UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.formBorderColor))),
                    style: TextStyle(color: Color.whiteColor),
                    readOnly: true,
                    initialValue: this.user.address,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _copyToClipboard(context, "Address", this.user.address);
                },
                child: Icon(
                  Icons.content_copy,
                  color: Color.whiteColor,
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String title, String value) {
    final snackBar = SnackBar(
      content: Text("$title has been copied to clipboard"),
      duration: Duration(seconds: 1),
    );
    Scaffold.of(context).showSnackBar(snackBar);
    Clipboard.setData(new ClipboardData(text: value));
  }
}
