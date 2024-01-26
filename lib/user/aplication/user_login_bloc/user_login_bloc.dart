import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/domain/repository/user_function.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  UserCredential? userCredential;
  String? userId;
  UserLoginBloc() : super(UserLoginIntialState()) {
    on<UserAlredyLoginEvent>((event, emit) {
      userCredential = event.userCredential;
      userId = event.userId;
    });
    on<UserLoginLoadingEvent>((event, emit) async {
      emit(UserLoginLoadingState());
      final userResult = await UserFunction()
          .userLoginPasswordAndEmailChecking(event.email, event.password);
      if (userResult != false) {
        userId = userResult;
        emit(UserLoginSuccessState());
      } else {
        emit(UserLoginIntialState());
      }
    });
  }
}
