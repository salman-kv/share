import 'package:firebase_auth/firebase_auth.dart';

abstract class UserLoginEvent{}

class UserAlredyLoginEvent extends UserLoginEvent{
  final UserCredential userCredential;
  final String userId;
  UserAlredyLoginEvent( {required this.userId,required this.userCredential});
}

class UserLoginLoadingEvent extends UserLoginEvent{
  final String email;
  final String password;

  UserLoginLoadingEvent({required this.email, required this.password});
  
}

class UserLoginSuccessEvent extends UserLoginEvent{
  final String userId;
  UserLoginSuccessEvent({required this.userId});
}