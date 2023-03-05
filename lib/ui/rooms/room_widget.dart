import 'package:flutter/material.dart';

import '../../model/room.dart';
import '../chat/chat_screen.dart';

class RoomWidget extends StatelessWidget {
Room room ;
RoomWidget({required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ChatScreen.routeName,arguments: room);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow:  [
            BoxShadow(
              color: Colors.grey.shade500,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/${room.categoryId}.png',
            width: 70,height: 90,fit: BoxFit.fill,),
            SizedBox(height: 15,),
            Expanded(
              child: Text(room.title ,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
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
