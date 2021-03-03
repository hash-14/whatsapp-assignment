import 'package:mywhatsapp/model/users.dart';

class ChatModel {
  final users user;
  final users sender;
  final String message;
  final String time;
  final String chatRoomId;

  ChatModel({this.user, this.sender, this.message, this.time,this.chatRoomId});
}