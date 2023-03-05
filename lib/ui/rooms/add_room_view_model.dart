import 'package:chat/database/database_utils.dart';
import 'package:chat/ui/rooms/add_room_navigator.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomNavigator navigator;

  void createRoom(String title, String description, String categoryId) async {
    navigator.showLoading();
    try {
      var room = await DataBaseUtils.createRoomToFirebase(
          title, description, categoryId);
      navigator.hideLoading();
      navigator.showMessage('Room Created Successfully');
      navigator.navigateTo();
    } catch (error) {
      navigator.hideLoading();
      navigator.showMessage(error.toString());
    }
  }
}
