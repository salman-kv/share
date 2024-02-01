import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonWidget {
  toastWidget(String toastMessage) {
    return Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  errorSnackBar(String errorSnackBarMessage, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Text(errorSnackBarMessage,style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
