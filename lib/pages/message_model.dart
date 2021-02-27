class Message {
  final String sender;
  final String reciever;
  final String message;
  final String type;
  final String id;
  Message({
    this.id,
    this.type,
    this.message,
    this.reciever,
    this.sender,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      sender: map['sender'],
      reciever: map['reciever'],
      message: map['message'],
      type: map['type'],
    );
  }
}
