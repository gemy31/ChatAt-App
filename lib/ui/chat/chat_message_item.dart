import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/message.dart';
import '../../providers/user_provider.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  Message message;

  MessageItem({required this.message});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return userProvider.user?.id == message.senderId
        ? SentMessage(message: message)
        : ReceiveMessage(message: message);
  }
}

class SentMessage extends StatelessWidget {
  Message message;

  SentMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: Colors.blue,
            ),
            child: Text(
              message.content,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          //DateFormat.Hms().format(now)
          //DateTime.fromMillisecondsSinceEpoch(message.dateTime)
          Text(DateFormat.jm()
              .format(DateTime.fromMillisecondsSinceEpoch(message.dateTime))),
        ],
      ),
    );
  }
}

class ReceiveMessage extends StatelessWidget {
  Message message;

  ReceiveMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.grey.shade600,
            ),
            child: Text(
              message.content,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(DateFormat.jm()
              .format(DateTime.fromMillisecondsSinceEpoch(message.dateTime))),
        ],
      ),
    );
  }
}
