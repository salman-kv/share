import 'package:flutter/material.dart';
import 'package:share/user/presentation/const/const_color.dart';

class Styles {
  // *****************************************************************************************************************************

  // form filed style

  // *****************************************************************************************************************************
  formDecrationStyle({required String labelText, required Icon icon}) {
    return InputDecoration(
      border: InputBorder.none,
      fillColor: const Color.fromARGB(255, 242, 242, 242),
      filled: true,
      labelText: labelText,
      labelStyle: const TextStyle(
          color: Color.fromARGB(255, 111, 111, 111), fontSize: 16),
      prefixIcon: icon,
    );
  }

  formTextStyle(BuildContext context) {
    return  TextStyle(
      color:  MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.black : Colors.black,
      fontSize: 16,
    );
  }

  // *****************************************************************************************************************************

  //  forgot password style

  // *****************************************************************************************************************************

  passwordTextStyle() {
    return const TextStyle(
        color: Colors.grey, decoration: TextDecoration.underline);
  }
  // *****************************************************************************************************************************

  //  forgot password style

  // *****************************************************************************************************************************

  linkTextColorStyle(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!.copyWith(
        color: ConstColor().mainColorblue,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold);
  }

  // *****************************************************************************************************************************

  // evevated button style

  // *****************************************************************************************************************************

  elevatedButtonDecration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 157, 206, 255),
          Color.fromARGB(255, 146, 163, 253),
        ],
      ),
    );
  }

  elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, shadowColor: Colors.transparent);
  }

  elevatedButtonTextStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  }

  // *****************************************************************************************************************************

  // next button style

  // *****************************************************************************************************************************

  customNextButtonDecration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 157, 206, 255),
          Color.fromARGB(255, 146, 163, 253),
        ],
      ),
    );
  }

  customNextButtonChild() {
    return const Icon(
      Icons.navigate_next_outlined,
      color: Colors.white,
      size: 30,
    );
  }

  // *****************************************************************************************************************************

  // google Auth button style

  // *****************************************************************************************************************************

  googleAuthButtonDecration() {
    return BoxDecoration(
      border:
          Border.all(color: const Color.fromARGB(255, 214, 214, 214), width: 2),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
