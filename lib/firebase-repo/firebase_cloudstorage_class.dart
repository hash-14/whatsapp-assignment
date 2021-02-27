import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mywhatsapp/firebase-repo/firebase_firestore_class.dart';
import 'package:mywhatsapp/pages/chat.dart';

class FirebaseCloudStorageClass {
  FirebaseFirestoreClass firebaseFirestoreClass = FirebaseFirestoreClass();

  uploadImage(ChatModel chatModel, String uid, File image) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final StorageReference storageReferenceThumbnail =
        FirebaseStorage().ref().child(timestamp);

    final StorageUploadTask uploadTask =
        storageReferenceThumbnail.putFile(image);
    String imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    firebaseFirestoreClass.addMessage(chatModel, imageUrl, "image");
  }
}
