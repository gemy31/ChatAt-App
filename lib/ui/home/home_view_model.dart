import 'package:chat/database/database_utils.dart';
import 'package:chat/ui/home/home_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/room.dart';

class HomeViewModel extends ChangeNotifier{

  // HomeViewModel(){
  //   getRooms();
  // }
late HomeNavigator navigator ;
//List<Room> rooms = [];
 late Stream<QuerySnapshot<Room>> roomStream ;

   void getRooms(){
    roomStream =DataBaseUtils.getAllRooms();
  }
}