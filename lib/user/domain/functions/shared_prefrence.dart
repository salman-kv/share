import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass{

  // setting user id
   
  static setUserid(String userId)async{
    final sharedPreferece= await SharedPreferences.getInstance();
    sharedPreferece.setString('user', userId);
  }

  // seting user email in shared prefrence
  
  static setUserEmail(String userEmail)async{
    final sharedPreferece= await SharedPreferences.getInstance();
    sharedPreferece.setString('email', userEmail);
  }

  // removing userif from shared prefrence

  static deleteUserid()async{
    final sharedPreferece= await SharedPreferences.getInstance();
    sharedPreferece.setString('user', '');
  }

  // removing email from shared prefrence

  static deleteUserEmail()async{
    final sharedPreferece= await SharedPreferences.getInstance();
    sharedPreferece.setString('email', '');
  }

  // getting userif from shared prefrece

  static getUserId()async{
    final sharedPreferece= await SharedPreferences.getInstance();
    return sharedPreferece.getString('user');
  }

  // getting user email from shared prefrence

  static getUserEmail()async{
    final sharedPreferece= await SharedPreferences.getInstance();
    return sharedPreferece.getString('email');
  }

  // color shared prefrence
  static setColorIndex(int index)async{
    final sharedPreferece= await SharedPreferences.getInstance();
    sharedPreferece.setInt('color', index);
  }
  // color shared prefrence
  static getColorIndex()async{
    final sharedPreferece= await SharedPreferences.getInstance();
  var a= sharedPreferece.get('color');
  int val= a==null ? 0 :int.parse(a.toString());
   return val;
  }
  // color shared prefrence
  static deleteColorIndex()async{
    final sharedPreferece= await SharedPreferences.getInstance();
    sharedPreferece.setInt('color', 0);
  }
}