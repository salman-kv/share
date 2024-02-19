import 'package:flutter/material.dart';
import 'package:share/user/presentation/const/const_color.dart';

class DesignedText {
  welcomeShareText(BuildContext context) {
    return Column(
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'S',
              style: TextStyle(
                color: ConstColor().mainColorblue,
                fontSize: 60,
                fontWeight: FontWeight.w700,
                fontFamily: 'PoppIns'
              )),
           TextSpan(
              text: 'hare',
              style: TextStyle(
                color: MediaQuery.of(context).platformBrightness == Brightness.dark ?  Colors.white : Colors.black,
                fontSize:50,
                fontWeight: FontWeight.w600,
                fontFamily: 'poppins'
                )),
        ])),
      ],
    );
  }
}
