import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/domain/repository/user_function.dart';
import 'package:share/user/presentation/widgets/commen_widget.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  String? userCredential;
  String? userId;
  UserLoginBloc() : super(UserLoginIntialState()) {
    on<UserAlredyLoginEvent>((event, emit) {
      userCredential = event.userCredential;
      userId = event.userId;
    });
    on<UserLoginLoadingEvent>((event, emit) async {
      emit(UserLoginLoadingState());
      try{
        final userResult = await UserFunction()
          .userLoginPasswordAndEmailChecking(event.email, event.password);
      if (userResult != false) {
        userId = userResult;
        emit(UserLoginSuccessState());
      } else {
        CommonWidget().toastWidget('Invalid username or password');
        emit(UserLoginIntialState());
      }
      }catch(e){
        CommonWidget().toastWidget('$e');
      }
    });
  }
}
