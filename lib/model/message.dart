class Message {
  static String collectionName = 'Messages';

  String id;
  String content;
  int dateTime;
  String categoryId;
  String roomId;
  String senderId;
  String senderName;

  Message(
      { this.id= '',
      required this.content,
      required this.dateTime,
      required this.roomId,
      required this.senderId,
      required this.senderName,
      required this.categoryId});

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          content: json['content'] as String,
          dateTime: json['dateTime'] as int,
          roomId: json['roomId'] as String,
          senderId: json['senderId'] as String,
          senderName: json['senderName'] as String,
          categoryId: json['categoryId'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'dateTime': dateTime,
      'roomId': roomId,
      'senderId': senderId,
      'senderName': senderName,
      'categoryId': categoryId,
    };
  }
}
