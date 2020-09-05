import 'package:flutter/material.dart';
import 'package:montageapp/core/constants/colors.dart' as Color;
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/user_detail/presentation/page/user_detail_page.dart';

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
                        style: TextStyle(color: Color.whiteColor),
                      ),
                      subtitle: Text('${userList[index].email}',
                          style: TextStyle(color: Color.greyColor)),
                      leading: CircleAvatar(
                        backgroundColor: Color.greyColor,
                        child: Image.asset(userList[index].imgUrl),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserDetailPage(user: userList[index]),
                          ),
                        );
                      },
                    );
                  })
          )
        ],
      ),
    );
  }
}
