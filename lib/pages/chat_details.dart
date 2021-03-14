import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mywhatsapp/models/chatModel.dart';
import 'package:mywhatsapp/services/Firestore.dart';

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
  TextEditingController messageController = new TextEditingController();
  FirestoreService db = FirestoreService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              foregroundColor: Theme
                  .of(context)
                  .primaryColor,
              backgroundColor: Colors.amber,
              backgroundImage: NetworkImage(widget.model.avatarUrl),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Text(widget.model.name),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<ChatModel>>(
                stream: db.getAllMessages(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text('Data has error');
                  return snapshot != null && snapshot.hasData
                      ? Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          ChatModel chatModel = snapshot.data.elementAt(index);
                          TextEditingController txtEdt = TextEditingController(
                              text: chatModel.message);

                          var valueLisenableIsEnabled = ValueNotifier(false);
                          return ValueListenableBuilder<bool>(
                            valueListenable: valueLisenableIsEnabled,
                            builder: (context, value, _) {
                              return ListTile(
                                onLongPress: () {
                                  /* Get.bottomSheet(
                                            Container(
                                              height: 70,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      db
                                                          .deleteMessage(
                                                              chatModel.docId)
                                                          .then((value) =>
                                                              Get.back());
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors.blueAccent,
                                                    ),
                                                    onPressed: () {
                                                      Get.back();
                                                      valueLisenableIsEnabled.value = true;
                                                      /* db
                                                        .editMessage(
                                                            chatModel.docId,
                                                            txtEdt.text)
                                                        .then((value) =>
                                                            Get.back());*/
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            backgroundColor: Colors.white);*/
                                  valueLisenableIsEnabled.value = true;
                                },
                                leading: CircleAvatar(
                                  foregroundColor: Theme
                                      .of(context)
                                      .primaryColor,
                                  backgroundColor: Colors.amber,
                                  backgroundImage: NetworkImage(chatModel.avatarUrl),
                                ),
                                title: TextField(
                                  enabled: true,
                                  autofocus: true,
                                  controller: txtEdt,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: Colors.deepOrange)),

                                ),
                                subtitle: Visibility(
                                  visible: value,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          valueLisenableIsEnabled.value = false;
                                          db.editMessage(
                                              chatModel.docId, txtEdt.text).then((value) {
                                                if(chatModel.message.trim()!=txtEdt.text.trim())
                                            Get.snackbar(
                                                'Message Edited Successfully',
                                                '',
                                                backgroundColor: Colors.green);
                                                else
                                                  Get.snackbar(
                                                      'Message doesn\'t change !!',
                                                      '',
                                                      backgroundColor: Colors.white24);

                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          db
                                              .deleteMessage(
                                              chatModel.docId)
                                              .then((value) {
                                            Get.snackbar(
                                                'Message Deleted Successfully',
                                                '',
                                                backgroundColor: Colors.red);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Text(
                                    '${chatModel.time
                                        .toDate()
                                        .hour}:${chatModel.time
                                        .toDate()
                                        .minute}'),
                              );
                            },
                          );
                        }),
                  )
                      : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ));
                }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 100,
              child: TextField(
                cursorColor: Colors.blue,
                controller: messageController,
                decoration: InputDecoration(
                    hintText: 'Send a message',
                    labelStyle: TextStyle(color: Colors.deepOrange)),
              ),
            ),
            IconButton(
              alignment: Alignment.bottomRight,
              icon: Icon(
                Icons.send_outlined,
                color: Colors.green,
              ),
              onPressed: () {
                final msg = messageController.text.toString().trim();
                if (msg.isNotEmpty) {
                  ChatModel chatModel = widget.model;
                  chatModel.message = msg;
                  db.createMessage(chatModel).then((value) {
                    Get.snackbar('Message Sent Successfully', msg,
                        backgroundColor: Colors.blue);
                    messageController.text = '';
                  });
                } else
                  Get.defaultDialog(
                    title: 'Alert',
                    middleText: 'Please enter a valid message !',
                    titleStyle: TextStyle(color: Colors.deepOrange),
                  );
              },
            )
          ],
        ),
      ),
    );
  }
}
