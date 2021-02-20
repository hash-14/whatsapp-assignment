import 'package:flutter/material.dart';
import 'package:mywhatsapp/pages/chat.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatModel model;
  ChatDetailScreen({
    this.model,
  });
  @override
  ChatDetailState createState() {
    return ChatDetailState();
  }
}

class ChatDetailState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(widget.model.avatarUrl),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Text(widget.model.name),
          ],
        ),
      ),
      body: Center(
        child: Text("assignment goes here"),
      ),
    );
  }
}
