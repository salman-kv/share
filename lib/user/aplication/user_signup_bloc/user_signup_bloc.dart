import 'dart:developer';
import 'package:email_otp/email_otp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_event.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/shared_prefrence.dart';
import 'package:share/user/domain/functions/user_function.dart';
import 'package:share/user/presentation/widgets/commen_widget.dart';

class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  // UserCredential? userCredential;
  String? email;
  XFile? image;
  String? userid;
  EmailOTP myAuth = EmailOTP();
  UserSignUpBloc() : super(InitialUserSignUp()) {
    on<OnclickUserSignUpAuthentication>(
      (event, emit) async {
        try {
          emit(UserSignupLoading());
          print('++___________++++++++++++___________________');
          final authResult = await UserFunction().signInWithGoogle();
          print('+++++++++++++++++');
          print(authResult);
          if (authResult != null) {
            log('????????????????????????????????????????');
            email = authResult!.user!.email!;
            final userReturnId = await UserFunction()
                .checkUserIsAlredyTheirOrNot(
                    email!, FirebaseFirestoreConst.firebaseFireStoreEmail);
                    log('//////////////////////////////////////');
                    log('$userReturnId');
            if (userReturnId != false) {
              userid = userReturnId;
              SharedPreferencesClass.setUserid(userid!);
              SharedPreferencesClass.setUserEmail(email!);
              emit(UserAlredySignupState(
                  userCredential: email!, userId: userReturnId));
            } else {
              emit(UserSignupAuthenticationSuccess());
            }
          } else {
            emit(InitialUserSignUp());
            log('Some user error');
          }
        } catch (e) {
          emit(InitialUserSignUp());
          CommonWidget().toastWidget('$e');
          log('$e');
        }
      },
    );
    on<OnVarifyUserDetailsEvent>((event, emit) async {
      emit(UserSignupLoading());
      print('{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{object}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}');
      final userResult =
          await UserFunction().addUserDeatails(event.userModel, event.compire);
      userid = userResult;
      print(']]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
      SharedPreferencesClass.setUserid(userid!);
      SharedPreferencesClass.setUserEmail(email!);
        image=null;
      emit(UserVerifiedWithMoredataState(
          userCredential: email!, userId: userResult));
    });
     on<OnlyForLoadingevent>((event, emit){
      emit(UserSignupLoading());
    });
    on<OnAddUserSignUpImage>((event, emit) {
      image = event.image;
      emit(UserSignupImagePickSuccess(image: event.image));
    });
    on<ManualEmailCheckingEvent>((event, emit) async {
      emit(ManualEmailCheckingLoadingState());
      myAuth.setConfig(
          appEmail: "kvsalu16@gmail.com",
          appName: 'email otp',
          userEmail: event.email,
          otpLength: 4,
          otpType: OTPType.digitsOnly);
      final userReturnId = await UserFunction().checkUserIsAlredyTheirOrNot(
          event.email, FirebaseFirestoreConst.firebaseFireStoreEmail);
      if (userReturnId == false) {
        var val = await myAuth.sendOTP();
        if (val) {
          email = event.email;
          emit(ManualEmailCheckingSuccessState(email: event.email));
        } else {
          emit(UserSignupErrorState());
          emit(InitialUserSignUp());
        }
      } else {
        emit(UserAlreadySignupErrorState());
      }
    });
    on<ManualOtpCheckingEvent>((event, emit) async {
      emit(ManualEmailCheckingLoadingState());
      var res = await myAuth.verifyOTP(otp: event.otp);
      if (res) {
        emit(ManualOtpCheckingSuccessState());
      } else {
        emit(UserOtpVerifyErrorState());
      }
    });
   
  }
}
