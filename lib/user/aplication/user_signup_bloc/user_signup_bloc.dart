import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_state.dart';

class UserSignUpBloc extends Bloc<UserSignUpBloc,UserSignUpState>{
  UserSignUpBloc() : super(InitialUserSignUp()){
    
  }

}