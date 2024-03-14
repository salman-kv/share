
abstract class UserLoginState{}

class UserLoginIntialState extends UserLoginState{}
class UserLoginLoadingState extends UserLoginState{}
class UserLoginSuccessState extends UserLoginState{}
class UserLoginErrorState extends UserLoginState{}
class UserFavAddedState extends UserLoginState{}
class UserFavRemoveState extends UserLoginState{}
class UserDeatailsUpdatedState extends UserLoginState{
  final String image;

  UserDeatailsUpdatedState({required this.image});
}
class UserDeatailsUpdatingState extends UserLoginState{}
class UserImageUpdatedState extends UserLoginState{}
class UserDeatailedAddigPendingState extends UserLoginState{}