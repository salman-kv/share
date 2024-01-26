import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_event.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/repository/user_function.dart';

class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  UserCredential? userCredential;
  String? image;
  String? userid;
  UserSignUpBloc() : super(InitialUserSignUp()) {
    on<OnclickUserSignUpAuthentication>(
      (event, emit) async {
        try {
          emit(UserSignupLoading());
          final authResult = await UserFunction().signInWithGoogle();
          if (authResult != null) {
            userCredential = authResult;
            final userReturnId = await UserFunction()
                .checkUserIsAlredyTheirOrNot(userCredential!.user!.email!,
                    FirebaseFirestoreConst().firebaseFireStoreEmail);
            if (userReturnId != false) {
              userid=userReturnId;
              emit(UserAlredySignupState(userCredential: authResult,userId: userReturnId));
            } else {
              emit(UserSignupAuthenticationSuccess());
            }
          } else {
            log('Some user error');
          }
        } catch (e) {
          emit(InitialUserSignUp());
          Fluttertoast.showToast(
              msg: '$e',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          log('$e');
        }
      },
    );
    on<OnVarifyUserDetailsEvent>((event, emit) async {
      emit(UserSignupLoading());
      final userResult = await UserFunction()
          .addUserDeatails(event.userModel, event.compire);
          userid=userResult;
      emit(UserVerifiedWithMoredataState(userCredential: userCredential!,userId: userResult));
    });
    on<OnAddUserSignUpImage>((event, emit) {
      image = event.image;
      emit(UserSignupImagePickSuccess(image: event.image));
    });
  }
}
