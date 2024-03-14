import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConstColor {
  ConstColor._privat();
  static final ConstColor _instance = ConstColor._privat();
  factory ConstColor() {
    return _instance;
  }
  Color mainColorblue = const Color.fromARGB(255, 146, 163, 253);
  Color main2Colorblue = const Color.fromARGB(255, 157, 206, 255);
  Color blackLetter = Colors.black;
  Color bottomNavIconColor = Colors.grey;

  changeColor(){
    mainColorblue=Colors.black;
  }
}
