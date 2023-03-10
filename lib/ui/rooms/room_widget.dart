import 'package:flutter/material.dart';

import '../../model/room.dart';
import '../chat/chat_screen.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget({required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: room);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${room.categoryId}.png',
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height * .09,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Text(
                room.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
