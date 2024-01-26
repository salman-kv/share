import 'package:firebase_auth/firebase_auth.dart';

abstract class UserSignUpState{}

class InitialUserSignUp extends UserSignUpState{}
class UserSignupLoading extends UserSignUpState{}
class UserSignupAuthenticationSuccess extends UserSignUpState{}
class UserSignupImagePickSuccess extends UserSignUpState{
  final String image;
  UserSignupImagePickSuccess({required this.image});
}
class UserAlredySignupState extends UserSignUpState{
 final  UserCredential userCredential;
 final String userId;
  UserAlredySignupState({required this.userId,required this.userCredential});
}
class UserVerifiedWithMoredataState extends UserSignUpState{
  final  UserCredential userCredential;
 final String userId;

  UserVerifiedWithMoredataState({required this.userCredential, required this.userId});
}