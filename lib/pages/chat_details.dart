import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mywhatsapp/constants/strings.dart';
import 'package:mywhatsapp/firebase-repo/firebase_cloudstorage_class.dart';
import 'package:mywhatsapp/firebase-repo/firebase_firestore_class.dart';
import 'package:mywhatsapp/pages/chat.dart';
import 'package:mywhatsapp/pages/message_model.dart';

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
  TextEditingController messageController = TextEditingController();
  TextEditingController editMessageController = TextEditingController();
  bool senderMessageNotEmpty = false;
  FirebaseFirestoreClass firebaseFirestoreClass = FirebaseFirestoreClass();
  FirebaseCloudStorageClass firebaseCloudStorageClass =
      FirebaseCloudStorageClass();
  File _image;
  final picker = ImagePicker();
  ScrollController scrollController = ScrollController();
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
        body: Column(
          children: [
            Flexible(
              child: messageListWidget(),
            ),
            sendChatWidget(),
          ],
        ));
  }

  sendChatWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              onChanged: (message) {
                messageNotEmpty(message.trim().isNotEmpty);
              },
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                suffixIcon: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // added line
                  mainAxisSize: MainAxisSize.min, // added line
                  children: <Widget>[
                    senderMessageNotEmpty
                        ? Container()
                        : IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              size: 30,
                            ),
                            onPressed: () {
                              getImageCamera();
                            },
                          ),
                    senderMessageNotEmpty
                        ? Container()
                        : IconButton(
                            icon: Icon(
                              Icons.photo,
                              size: 30,
                            ),
                            onPressed: () {
                              getImageGallery();
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
          senderMessageNotEmpty
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(18, 140, 126, 1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (senderMessageNotEmpty) {
                        firebaseFirestoreClass.addMessage(
                            widget.model, messageController.text, "text");
                        messageController.text = "";
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          scrollController.animateTo(
                            scrollController.position.minScrollExtent,
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 250),
                          );
                        });
                      }
                      messageNotEmpty(messageController.text.isNotEmpty);
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  messageListWidget() {
    return StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestoreClass.bindUserMessages(USER_ID, widget.model),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(senderMessageNotEmpty);
          if (snapshot.data != null) {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data.docs.length,
              reverse: true,
              controller: scrollController,
              itemBuilder: (context, index) {
                Message myMessage =
                    Message.fromMap(snapshot.data.docs[index].data());
                return chatMessageItemWidget(myMessage);
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  chatMessageItemWidget(Message message) {
    return GestureDetector(
      onLongPress: () {
        message.type == "text"
            ? showEditDeleteDialog(context, message)
            : showDeleteAlertDialog(context, message);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65),
            decoration: BoxDecoration(
              color: Color.fromRGBO(37, 211, 102, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: message.type == "text"
                  ? Text(message.message)
                  : Image.network(message.message),
            ),
          ),
        ),
      ),
    );
  }

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        firebaseCloudStorageClass.uploadImage(widget.model, USER_ID, _image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        firebaseCloudStorageClass.uploadImage(widget.model, USER_ID, _image);
      } else {
        print('No image selected.');
      }
    });
  }

  messageNotEmpty(bool message) {
    setState(() {
      senderMessageNotEmpty = message;
    });
  }

  showEditDeleteDialog(BuildContext context, Message message) {
    AlertDialog alert = AlertDialog(
      title: Text(message.message),
      content: Container(
        width: 50,
        height: 80,
        child: ListView.separated(
          itemCount: 2,
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context, int index) {
            return index == 0
                ? GestureDetector(
                    onTap: () {
                      showEditAlertDialog(context, message);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text("Edit"),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      showDeleteAlertDialog(context, message);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text("Delete"),
                    ),
                  );
          },
        ),
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDeleteAlertDialog(BuildContext context, Message message) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        if (message.type == "text") {
          Navigator.pop(context);
        }
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        if (message.type == "text") {
          Navigator.pop(context);
        }
        Navigator.pop(context);
        firebaseFirestoreClass.deleteMessage(widget.model, message);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure to delete the message?"),
      content: message.type == "text"
          ? Text(
              message.message,
            )
          : FittedBox(
              fit: BoxFit.contain,
              child: Image.network(message.message),
            ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showEditAlertDialog(BuildContext context, Message message) {
    editMessageController.text = message.message;
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Edit"),
      onPressed: () {
        firebaseFirestoreClass.updateMessage(
            widget.model, message, editMessageController.text);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Your Message"),
      content: TextField(
        controller: editMessageController,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
