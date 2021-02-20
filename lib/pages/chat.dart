import 'package:flutter/material.dart';
import 'package:mywhatsapp/pages/chat_details.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, i) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatDetailScreen(
                  model: dummyData[i],
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
                backgroundImage: NetworkImage(dummyData[i].avatarUrl),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    dummyData[i].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    dummyData[i].time,
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ],
              ),
              subtitle: Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  dummyData[i].message,
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

class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  ChatModel({this.name, this.message, this.time, this.avatarUrl});
}

List<ChatModel> dummyData = [
  ChatModel(
      name: "Kamlesh Vaghela",
      message: "Hey Kamlesh, How Are you ?",
      time: "10:00 PM",
      avatarUrl:
          "https://www.biography.com/.image/t_share/MTY2MzU3OTcxMTUwODQxNTM1/steve-jobs--david-paul-morrisbloomberg-via-getty-images.jpg"),
  ChatModel(
      name: "Martin Vaghela",
      message: "Hi Martin, I want to learn Flutter",
      time: "12:00 PM",
      avatarUrl:
          "https://4.bp.blogspot.com/-bn0_W5vPB0M/V044_oa_d3I/AAAAAAAAAcQ/TOcG4dBQIk89ozVQ32z3E1dSHheRPsypgCLcB/s1600/semiprofileoval1.jpg"),
  ChatModel(
      name: "Vasant Thakor",
      message: "Wassup !",
      time: "05:00 AM",
      avatarUrl:
          "https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg"),
  ChatModel(
      name: "Mukesh Vaghela",
      message: "Flutter is the coolest Language !",
      time: "10:30 AM",
      avatarUrl:
          "https://www.cheatsheet.com/wp-content/uploads/2019/06/RDJ-Tony-Stark.jpg"),
  ChatModel(
      name: "Vinod Vaghela",
      message: "Call me when free",
      time: "02:30 AM",
      avatarUrl:
          "https://www.cheatsheet.com/wp-content/uploads/2019/06/RDJ-Tony-Stark.jpg"),
  ChatModel(
      name: "Kailash Vaghela",
      message: "What are you doing man ?",
      time: "05:30 PM",
      avatarUrl:
          "https://i.insider.com/5e223467b6d52d35156b89ac?width=1100&format=jpeg&auto=webp"),
  ChatModel(
      name: "Manoj Vaghela",
      message: "Are you there ? Manoj",
      time: "06:00 PM",
      avatarUrl:
          "https://i.pinimg.com/736x/ea/f2/2e/eaf22e6a189f76ed24054e2ca7feb00f.jpg"),
  ChatModel(
      name: "Kishan Mevada",
      message: "Kishanbhai, I need your Help",
      time: "06:00 PM",
      avatarUrl:
          "https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg"),
  ChatModel(
      name: "Krunal Gauswami",
      message: "Hi Krunal Bro",
      time: "06:00 PM",
      avatarUrl:
          "https://i.pinimg.com/736x/ea/f2/2e/eaf22e6a189f76ed24054e2ca7feb00f.jpg"),
  ChatModel(
      name: "Pravin Desai",
      message: "Send me that file Pravin",
      time: "06:00 PM",
      avatarUrl:
          "https://4.bp.blogspot.com/-bn0_W5vPB0M/V044_oa_d3I/AAAAAAAAAcQ/TOcG4dBQIk89ozVQ32z3E1dSHheRPsypgCLcB/s1600/semiprofileoval1.jpg"),
  ChatModel(
      name: "Ashok Thakor",
      message: "How's your Farm Ashok",
      time: "06:00 PM",
      avatarUrl:
          "https://www.biography.com/.image/t_share/MTY2MzU3OTcxMTUwODQxNTM1/steve-jobs--david-paul-morrisbloomberg-via-getty-images.jpg"),
];
