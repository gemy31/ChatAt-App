import 'package:chat/database/database_utils.dart';
import 'package:chat/model/message.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/ui/chat/chat_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/room.dart';

class ChatScreenViewModel extends ChangeNotifier {
  late ChatNavigator navigator;

  late Room room;

  late MyUser? currentUser;
  late Stream<QuerySnapshot<Message>> streamMessage;

  void sendMessage(String messageContent) async {
    if (messageContent.trim().isEmpty) {
      return;
    }
    Message message = Message(
        content: messageContent,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        roomId: room.id,
        senderId: currentUser?.id ?? '',
        senderName: currentUser?.userName ?? '',
        categoryId: room.categoryId);
    try {
      var result = await DataBaseUtils.insertMessageToFireBase(message);
      navigator.clearMessage();
    } catch (error) {
      navigator.showMessage(error.toString());
    }
  }

  void updateMessages() {
    streamMessage = DataBaseUtils.getMessages(room.id);
  }
}
