import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

   void showLoading(BuildContext context, String message,
      {bool isCancel = false}) {
    showDialog(
        barrierDismissible: isCancel,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 18,
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ],
            ),
          );
        });
  }

   void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  void showMessage(BuildContext context, String message, String posActionText,
      Function posAction,
      {String? negActionText = null, Function? negAction = null}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () {
                    posAction(context);
                  },
                  child: Text(posActionText),
                ),
              ),
            ],
          );
        });
  }


