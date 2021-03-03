import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mywhatsapp/model/ChatModel.dart';
import 'package:mywhatsapp/model/users.dart';
import 'package:mywhatsapp/pages/chat_details.dart';
import 'package:mywhatsapp/services/database.dart';
import  'package:flutter/src/rendering/box.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

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
                backgroundImage: NetworkImage(dummyUsers[i].avatarUrl),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    dummyUsers[i].name,
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
List<users> dummyUsers = [
   users( name :"Kamlesh Vaghela",
      avatarUrl: "https://www.biography.com/.image/t_share/MTY2MzU3OTcxMTUwODQxNTM1/steve-jobs--david-paul-morrisbloomberg-via-getty-images.jpg"),
  users( name: "Martin Vaghela",
      avatarUrl: "https://4.bp.blogspot.com/-bn0_W5vPB0M/V044_oa_d3I/AAAAAAAAAcQ/TOcG4dBQIk89ozVQ32z3E1dSHheRPsypgCLcB/s1600/semiprofileoval1.jpg"),
  users( name :"Vasant Thakor",
      avatarUrl: "https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg"),
  users( name :"Mukesh Vaghela",
      avatarUrl: "https://www.cheatsheet.com/wp-content/uploads/2019/06/RDJ-Tony-Stark.jpg"),
  users( name :"Vinod Vaghela",
      avatarUrl: "https://www.cheatsheet.com/wp-content/uploads/2019/06/RDJ-Tony-Stark.jpg"),
  users( name :"Kailash Vaghela",
      avatarUrl: "https://i.insider.com/5e223467b6d52d35156b89ac?width=1100&format=jpeg&auto=webp"),
  users( name :"Manoj Vaghela",
      avatarUrl: "https://i.pinimg.com/736x/ea/f2/2e/eaf22e6a189f76ed24054e2ca7feb00f.jpg"),
  users( name :"Kishan Mevada",
      avatarUrl: "https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg"),
  users( name :"Krunal Gauswami",
      avatarUrl: "https://i.pinimg.com/736x/ea/f2/2e/eaf22e6a189f76ed24054e2ca7feb00f.jpg"),
  users( name :"Pravin Desai",
      avatarUrl: "https://4.bp.blogspot.com/-bn0_W5vPB0M/V044_oa_d3I/AAAAAAAAAcQ/TOcG4dBQIk89ozVQ32z3E1dSHheRPsypgCLcB/s1600/semiprofileoval1.jpg"),
  users( name :"Ashok Thakor",
      avatarUrl: "https://www.biography.com/.image/t_share/MTY2MzU3OTcxMTUwODQxNTM1/steve-jobs--david-paul-morrisbloomberg-via-getty-images.jpg"),
  users( name :"Hussein Hammoud",
      avatarUrl: "")
];
List<ChatModel> dummyData = [
  ChatModel(
      user: dummyUsers[0],
      sender: dummyUsers[11],
      message: "Hey Kamlesh, How Are you ?",
      time: "10:00 PM",
          ),
  ChatModel(
      user: dummyUsers[1],
    sender: dummyUsers[11],
      message: "Hi Martin, I want to learn Flutter",
      time: "12:00 PM",),
  ChatModel(
      user: dummyUsers[2],
    sender: dummyUsers[11],
      message: "Wassup !",
      time: "05:00 AM",),
  ChatModel(
      user: dummyUsers[3],
    sender: dummyUsers[11],
      message: "Flutter is the coolest Language !",
      time: "10:30 AM",),
  ChatModel(
      user: dummyUsers[4],
    sender: dummyUsers[11],
      message: "Call me when free",
      time: "02:30 AM",),
  ChatModel(
    user: dummyUsers[5],
    sender: dummyUsers[11],
    message: "What are you doing man ?",
      time: "05:30 PM",),
  ChatModel(
      user: dummyUsers[6],
      sender: dummyUsers[11],
      message: "Are you there ? Manoj",
      time: "06:00 PM"),
  ChatModel(
      user: dummyUsers[7],
      sender: dummyUsers[11],
      message: "Kishanbhai, I need your Help",
      time: "06:00 PM"),
  ChatModel(
      user: dummyUsers[8],
      sender: dummyUsers[11],
      message: "Hi Krunal Bro",
      time: "06:00 PM"),
  ChatModel(
      user: dummyUsers[9],
      sender: dummyUsers[11],
      message: "Send me that file Pravin",
      time: "06:00 PM"),
  ChatModel(
      user: dummyUsers[10],
      sender: dummyUsers[11],
      message: "How's your Farm Ashok",
      time: "06:00 PM"),
];


