import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ChatModel {


   String _name;
   String _message;
   Timestamp _time;
  String _avatarUrl;
   String _docId;


   ChatModel({
      String name, String message, Timestamp time, String avatarUrl}):
   _name=name,
   _message=message,
   _time=time,
   _avatarUrl=avatarUrl;


   set name(String value) {
    _name = value;
  }

  ChatModel.fromJson(Map<String, dynamic> map)
      : _docId=map['docId'],
        _name = map['name'],
        _message = map['message'],
        _time = map['time'],
        _avatarUrl = map['avatarUrl'];


   set message(String value) {
    _message = value;
  }


   String get name => _name;

  Map<String, dynamic> toJson() =>
      {'docId':_docId,'name': _name, 'message': _message, 'time': _time, 'avatarUrl': _avatarUrl};

   String get message => _message;



   String get avatarUrl => _avatarUrl;

   String get docId => _docId;

   @override
  String toString() {
    return 'ChatModel{_name: $_name, _message: $_message, _time: $_time, _avatarUrl: $_avatarUrl, _docId: $_docId}';
  }


   Timestamp get time => _time;


   set time(Timestamp value) {
    _time = value;
  }

  set avatarUrl(String value) {
    _avatarUrl = value;
  }

   set docId(String value) {
    _docId = value;
  }
}


