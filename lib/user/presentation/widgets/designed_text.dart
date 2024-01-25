import 'package:flutter/material.dart';
import 'package:share/user/presentation/const/const_color.dart';

class DesignedText {
  welcomeShareText() {
    return Column(
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'S',
              style: TextStyle(
                color: ConstValues().mainColorblue,
                fontSize: 60,
                fontWeight: FontWeight.w700,
                fontFamily: 'PoppIns'
              )),
          TextSpan(
              text: 'hare',
              style: TextStyle(
                color: ConstValues().blackLetter,
                fontSize:50,
                fontWeight: FontWeight.w600,
                fontFamily: 'poppins'
                )),
        ])),
      ],
    );
  }
}
