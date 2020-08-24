import 'package:flutter/material.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class GenerateUserList extends StatelessWidget {
  final List<User> userList;

  const GenerateUserList({Key key, @required this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                          '${userList[index].name}',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text('${userList[index].email}',
                            style: TextStyle(color: Colors.grey[350])),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset(userList[index].imgUrl),
                        )
                    );
                  })
          )
        ],
      ),
    );
  }
}
