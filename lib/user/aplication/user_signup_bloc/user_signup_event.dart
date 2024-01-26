import 'package:share/user/domain/model/user_model.dart';

abstract class UserSignUpEvent{}

class OnclickUserSignUpAuthentication extends UserSignUpEvent{
}

class OnAddUserSignUpImage extends UserSignUpEvent{
  String image;
  OnAddUserSignUpImage({required this.image});
}
class OnVarifyUserDetailsEvent extends UserSignUpEvent{
  final UserModel userModel;
  final String compire;

  OnVarifyUserDetailsEvent({required this.userModel, required this.compire});
}