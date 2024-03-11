// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/shared_prefrence.dart';
import 'package:share/user/domain/functions/user_firestroe_funciton.dart';
import 'package:share/user/domain/model/user_model.dart';
import 'package:share/user/presentation/alerts/toasts.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  // String? userCredential;
  String? userId;
  UserModel? userModel;
  UserLoginBloc() : super(UserLoginIntialState()) {
    on<UserAlredyLoginEvent>((event, emit) {
      userId = event.userId;
      SharedPreferencesClass.setUserid(event.userId);
      SharedPreferencesClass.setUserEmail(event.userCredential);
      log('emit user seatatl adding state');
      emit(UserDeatailedAddigPendingState());
    });
    on<UserDeatailesAddingEvent>((event, emit) async {
      emit(UserLoginLoadingState());
      userId = event.userId;
      log('$userId');
      DocumentSnapshot<Map<String, dynamic>> instant = await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection)
          .doc(userId)
          .get();
         
      Map<String, dynamic> data = instant.data() as Map<String, dynamic>;
      userModel = UserModel.fromMap(data, event.userId);
      log('loginSuccess');
      emit(UserLoginSuccessState());
    });
    on<UserLoginLoadingEvent>((event, emit) async {
      emit(UserLoginLoadingState());
      try {
        final userResult = await UserFireStroreFunction()
            .userLoginPasswordAndEmailChecking(event.email, event.password);
        if (userResult != false) {
          userId = userResult;
          SharedPreferencesClass.setUserid(userId!);
          SharedPreferencesClass.setUserEmail(event.email);
          emit(UserDeatailedAddigPendingState());
        } else {
          emit(UserLoginErrorState());
        }
      } catch (e) {
        Toasts().toastWidget('$e');
      }
    });
  }
}
