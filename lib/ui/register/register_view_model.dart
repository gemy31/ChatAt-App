import 'package:chat/database/database_utils.dart';
import 'package:chat/firebase_errors.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/ui/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterViewModel extends ChangeNotifier{
  late RegisterNavigator navigator ;
  void registerUser(String email , String password,
      String firstName , String lastName,String userName)async{
    //show loading
    navigator.showLoading();
    try {
      final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser user = MyUser(
          id: response.user?.uid ?? '',
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email);
      var task = await DataBaseUtils.createUser(user);
      navigator.hideLoading();
      navigator.showMessage('You are registered successfully');
      navigator.goToHome(user);
      print(response.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseError.weakPassword) {
        //hide loading
        //show message
        navigator.hideLoading();
        navigator.showMessage('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == FireBaseError.emailUsed) {
        //hide loading
        //show message
        navigator.hideLoading();
        navigator.showMessage('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}