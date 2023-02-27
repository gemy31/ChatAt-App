import 'package:chat/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/database_utils.dart';

class UserProvider extends ChangeNotifier{
  MyUser? user ;
  User? fireBaseAuthUser ;
  UserProvider(){
    fireBaseAuthUser = FirebaseAuth.instance.currentUser ;
    initMyUser();
  }
  void initMyUser()async{
    if(fireBaseAuthUser != null){
      user = await DataBaseUtils.readUser(fireBaseAuthUser?.uid ?? '');
    }
  }

}