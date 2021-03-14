import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mywhatsapp/models/chatModel.dart';

class FirestoreService {
  FirebaseFirestore db;

  FirestoreService() {
    db = FirebaseFirestore.instance;
  }

  List<ChatModel> dummyData = [
    ChatModel(
        name: "Kamlesh Vaghela",
        message: "Hey Kamlesh, How Are you ?",
        time: Timestamp.now(),
        avatarUrl:
            "https://www.biography.com/.image/t_share/MTY2MzU3OTcxMTUwODQxNTM1/steve-jobs--david-paul-morrisbloomberg-via-getty-images.jpg"),
    ChatModel(
        name: "Martin Vaghela",
        message: "Hi Martin, I want to learn Flutter",
        time: Timestamp.now(),
        avatarUrl:
            "https://4.bp.blogspot.com/-bn0_W5vPB0M/V044_oa_d3I/AAAAAAAAAcQ/TOcG4dBQIk89ozVQ32z3E1dSHheRPsypgCLcB/s1600/semiprofileoval1.jpg"),
    ChatModel(
        name: "Vasant Thakor",
        message: "Wassup !",
        time: Timestamp.now(),
        avatarUrl:
            "https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg"),
    ChatModel(
        name: "Mukesh Vaghela",
        message: "Flutter is the coolest Language !",
        time: Timestamp.now(),
        avatarUrl:
            "https://www.cheatsheet.com/wp-content/uploads/2019/06/RDJ-Tony-Stark.jpg"),
    ChatModel(
        name: "Vinod Vaghela",
        message: "Call me when free",
        time: Timestamp.now(),
        avatarUrl:
            "https://www.cheatsheet.com/wp-content/uploads/2019/06/RDJ-Tony-Stark.jpg"),
    ChatModel(
        name: "Kailash Vaghela",
        message: "What are you doing man ?",
        time: Timestamp.now(),
        avatarUrl:
            "https://i.insider.com/5e223467b6d52d35156b89ac?width=1100&format=jpeg&auto=webp"),
    ChatModel(
        name: "Manoj Vaghela",
        message: "Are you there ? Manoj",
        time: Timestamp.now(),
        avatarUrl:
            "https://i.pinimg.com/736x/ea/f2/2e/eaf22e6a189f76ed24054e2ca7feb00f.jpg"),
    ChatModel(
        name: "Kishan Mevada",
        message: "Kishanbhai, I need your Help",
        time: Timestamp.now(),
        avatarUrl:
            "https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg"),
    ChatModel(
        name: "Krunal Gauswami",
        message: "Hi Krunal Bro",
        time: Timestamp.now(),
        avatarUrl:
            "https://i.pinimg.com/736x/ea/f2/2e/eaf22e6a189f76ed24054e2ca7feb00f.jpg"),
    ChatModel(
        name: "Pravin Desai",
        message: "Send me that file Pravin",
        time: Timestamp.now(),
        avatarUrl:
            "https://4.bp.blogspot.com/-bn0_W5vPB0M/V044_oa_d3I/AAAAAAAAAcQ/TOcG4dBQIk89ozVQ32z3E1dSHheRPsypgCLcB/s1600/semiprofileoval1.jpg"),
    ChatModel(
        name: "Ashok Thakor",
        message: "How's your Farm Ashok",
        time: Timestamp.now(),
        avatarUrl:
            "https://www.biography.com/.image/t_share/MTY2MzU3OTcxMTUwODQxNTM1/steve-jobs--david-paul-morrisbloomberg-via-getty-images.jpg"),
  ];

  Stream<List<ChatModel>> getAllMessages() {
    Stream<QuerySnapshot> stream = db.collection('Chats').orderBy('time',descending: false).snapshots();
    return stream.map((qShot) =>
        qShot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList());
  }

  Future<void> createDummyData(List<ChatModel> chatModels) {
    chatModels.map((model) => db.collection('Chats').add(model.toJson()));
  }

  Future<void> createMessage(ChatModel chatModel) async {
   String dId= db.collection('Chats').doc().id;
   chatModel.docId=dId;
   chatModel.time=Timestamp.now();
   await db.collection('Chats').doc(dId).set(chatModel.toJson());


  }

  Future<void> addDummyData(List<ChatModel> chatModels) async {}

  Future<void> editMessage(String docId, String msg) async {
    await db.collection('Chats').doc(docId).update({'message': msg});
  }

  Future<void> deleteMessage(String docId) async {
    await db.collection('Chats').doc(docId).delete();
  }
}
