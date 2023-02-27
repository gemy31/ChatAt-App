import 'package:chat/database/database_utils.dart';
import 'package:chat/firebase_errors.dart';
import 'package:chat/ui/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier{
  late LoginNavigator navigator ;
  void loginUserToFireBase(String email ,String password)async{
    navigator.showLoading();
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      var userObject = await DataBaseUtils.readUser(result.user?.uid??'');
      if(userObject == null){
        navigator.hideLoading();
        navigator.showMessage('Login Failed');
      }else{
        navigator.hideLoading();
        navigator.showMessage('Login Successfully');
        navigator.navigateToHome();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseError.userNotFound) {
        navigator.hideLoading();
        navigator.showMessage('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == FireBaseError.wrongPassword) {
        navigator.hideLoading();
        navigator.showMessage('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
  }
}