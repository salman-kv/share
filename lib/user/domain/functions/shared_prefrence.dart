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
}