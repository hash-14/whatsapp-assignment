import 'package:flutter/material.dart';
import 'package:mywhatsapp/models/chatModel.dart';
import 'package:mywhatsapp/pages/chat_details.dart';
import 'package:mywhatsapp/services/Firestore.dart';

class ChatScreen extends StatelessWidget {
  FirestoreService db=FirestoreService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: db.dummyData.length,
      itemBuilder: (context, i) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatDetailScreen(
                  model: db.dummyData[i],
                );
              },
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Divider(
              height: 10.0,
            ),
            ListTile(
              leading: CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(db.dummyData[i].avatarUrl),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    db.dummyData[i].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${db.dummyData[i].time.toDate().hour}:${db.dummyData[i].time.toDate().minute}',
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ],
              ),
              subtitle: Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  db.dummyData[i].message,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




