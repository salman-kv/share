import 'package:flutter/material.dart';
import 'package:share/user/domain/model/user_model.dart';

abstract class UserLoginEvent{}

class UserAlredyLoginEvent extends UserLoginEvent{
  final String userCredential;
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

class UserDeatailesAddingEvent extends UserLoginEvent{
  final String userId;
  final BuildContext context;

  UserDeatailesAddingEvent({required this.userId, required this.context});
}
class OnTapFavoriteEvent extends UserLoginEvent{
  final String roomId;

  OnTapFavoriteEvent({required this.roomId});
}
class OnProfileUpdatingState extends UserLoginEvent{
  final String userName;
  final String phone; 
  final String imagePath;

  OnProfileUpdatingState({required this.userName, required this.phone, required this.imagePath}); 

}
class OnImageUpdatingEvent extends UserLoginEvent{}