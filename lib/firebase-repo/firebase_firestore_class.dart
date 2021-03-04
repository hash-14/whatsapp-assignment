import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mywhatsapp/constants/strings.dart';
import 'package:mywhatsapp/pages/chat.dart';
import 'package:mywhatsapp/pages/message_model.dart';

class FirebaseFirestoreClass {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> bindUserMessages(String uid, ChatModel chatModel) {
    return firestore
        .collection(MESSAGE_COLLECTION)
        .doc(uid)
        .collection(chatModel.name)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  addMessage(ChatModel chatModel, String message, String type) {
    firestore
        .collection(MESSAGE_COLLECTION)
        .doc(USER_ID)
        .collection(chatModel.name)
        .add({
      "reciever": chatModel.name,
      "message": message,
      "senderId": USER_ID,
      "timestamp": FieldValue.serverTimestamp(),
      "type": type,
    }).then((value) => firestore
            .collection(MESSAGE_COLLECTION)
            .doc(USER_ID)
            .collection(chatModel.name)
            .doc(value.id)
            .update({"id": value.id}));
  }

  updateMessage(ChatModel chatModel, Message message, String editMessage) {
    firestore
        .collection(MESSAGE_COLLECTION)
        .doc(USER_ID)
        .collection(chatModel.name)
        .doc(message.id)
        .update({"message": editMessage});
  }

  deleteMessage(ChatModel chatModel, Message message) {
    firestore
        .collection(MESSAGE_COLLECTION)
        .doc(USER_ID)
        .collection(chatModel.name)
        .doc(message.id)
        .delete();
  }
}
