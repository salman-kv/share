
import 'dart:developer';
import 'package:flutter/material.dart';

class ConstColor {
  ConstColor._privat();
  static final ConstColor _instance = ConstColor._privat();
  factory ConstColor() {
    return _instance;
  }
  List<Map<String, dynamic>> listOfColor = [
    {
      "main": const Color.fromARGB(255, 146, 163, 253),
      "main2": const Color.fromARGB(255, 157, 206, 255)
    },
    {
      "main": const Color.fromARGB(255, 154, 139, 242),
      "main2": const Color.fromARGB(255, 159, 157, 210)
    },
    {
      "main": const Color.fromARGB(255, 33, 116, 99),
      "main2": const Color.fromARGB(255, 63, 185, 136)
    },
    {
      "main": Color.fromARGB(255, 125, 128, 39),
      "main2": Color.fromARGB(255, 179, 196, 67)
    },
    {
      "main": Color.fromARGB(255, 149, 32, 36),
      "main2": Color.fromARGB(255, 214, 58, 58)
    },
    {
      "main": Color.fromARGB(255, 33, 30, 154),
      "main2": Color.fromARGB(255, 54, 28, 168)
    },
  ];
  Color mainColorblue = const Color.fromARGB(255, 146, 163, 253);
  Color main2Colorblue = const Color.fromARGB(255, 157, 206, 255);
  Color blackLetter = Colors.black;
  Color bottomNavIconColor = Colors.grey;

  changeColor({required int index}) {
    log('${index}');
    mainColorblue = listOfColor[index]["main"];
    main2Colorblue = listOfColor[index]["main2"];
  }
}
