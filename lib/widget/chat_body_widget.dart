import 'package:mywhatsapp/model/message.dart';
import 'package:mywhatsapp/model/user.dart';
import 'package:mywhatsapp/pages/chat_page.dart';
import 'package:flutter/material.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<User> users;

  const ChatBodyWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: buildChats(),
      );

  Widget buildChats() => ListView.builder(
        itemBuilder: (context, index) {
          final user = users[index];

          return Container(
              color: Colors.white,
              height: 85,
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 10.0,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatPage(user: user),
                      ));
                    },
                    leading: CircleAvatar(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(user.urlAvatar),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          user.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text('message here',
                          style: TextStyle(color: Colors.grey, fontSize: 15.0)),
                    ),
                  )
                ],
              ));
        },
        itemCount: users.length,
      );
}
