import 'package:chat/model/my_user.dart';

abstract class RegisterNavigator{
  void hideLoading();
  void showLoading();
  void showMessage(String message);
  void goToHome(MyUser user);
}