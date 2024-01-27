abstract class UserSignUpState{}

class InitialUserSignUp extends UserSignUpState{}
class UserSignupLoading extends UserSignUpState{}
class UserSignupAuthenticationSuccess extends UserSignUpState{}
class UserSignupImagePickSuccess extends UserSignUpState{
  final String image;
  UserSignupImagePickSuccess({required this.image});
}
class UserAlredySignupState extends UserSignUpState{
 final  String userCredential;
 final String userId;
  UserAlredySignupState({required this.userId,required this.userCredential});
}
class UserVerifiedWithMoredataState extends UserSignUpState{
  final  String userCredential;
 final String userId;

  UserVerifiedWithMoredataState({required this.userCredential, required this.userId});
}
class ManualEmailCheckingLoadingState extends UserSignUpState{}
class ManualEmailCheckingSuccessState extends UserSignUpState{
  final String email;

  ManualEmailCheckingSuccessState({required this.email});
}
class ManualOtpCheckingSuccessState extends UserSignUpState{
  // final String email;

  // ManualOtpCheckingSuccessState({required this.email});

}