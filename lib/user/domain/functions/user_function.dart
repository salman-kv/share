import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserFunction {
  // user pick image and send the path of image

  userPickImage() async {
    try {
      var a = await ImagePicker().pickImage(source: ImageSource.gallery);
      return a;
    } catch (e) {
      log('$e');
    }
  }

  // oposit color selecting function

  opositColor(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? const Color.fromARGB(255, 0, 0, 0)
        : Colors.white;
  }

  // almost same as the common color
  backgroundColorAlmostSame(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? Color.fromARGB(255, 243, 243, 243)
        : const Color.fromARGB(255, 45, 45, 45);
  }
}
