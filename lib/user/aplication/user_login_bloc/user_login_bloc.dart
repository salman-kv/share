import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginBloc,UserLoginState>{
  UserLoginBloc() : super(UserLoginIntialState()){
    
  }
  
}