import 'package:image_picker/image_picker.dart';
import 'package:share/user/domain/model/user_model.dart';

abstract class UserSignUpEvent{}

class OnclickUserSignUpAuthentication extends UserSignUpEvent{
}

class OnAddUserSignUpImage extends UserSignUpEvent{
  XFile image;
  OnAddUserSignUpImage({required this.image});
}
class OnVarifyUserDetailsEvent extends UserSignUpEvent{
  final UserModel userModel;
  final String compire;

  OnVarifyUserDetailsEvent({required this.userModel, required this.compire});
}

class ManualEmailCheckingEvent extends UserSignUpEvent{
  final String email;

  ManualEmailCheckingEvent({required this.email});
}
class ManualOtpCheckingEvent extends UserSignUpEvent{
  final String otp;

  ManualOtpCheckingEvent({required this.otp});
}
class OnlyForLoadingevent extends UserSignUpEvent{}