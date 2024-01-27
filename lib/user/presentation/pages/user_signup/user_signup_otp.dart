import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_event.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_state.dart';
import 'package:share/user/presentation/pages/userLogin/user_login_page.dart';
import 'package:share/user/presentation/pages/user_signup/user_signup_more.dart';

import 'package:share/user/presentation/widgets/styles.dart';

class UserSignUpOtp extends StatelessWidget {
  UserSignUpOtp({super.key});

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Verify OTP',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  BlocConsumer<UserSignUpBloc, UserSignUpState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: TextFormField(
                                controller: otpController,
                                decoration: Styles().formDecrationStyle(
                                    icon: const Icon(Icons.mail_outlined),
                                    labelText: 'otp'),
                                style: Styles().formTextStyle(),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                height: MediaQuery.of(context).size.width * 0.1,
                                width: MediaQuery.of(context).size.width * 0.6,
                                decoration: Styles().elevatedButtonDecration(),
                                child: ElevatedButton(
                                    style: Styles().elevatedButtonStyle(),
                                    onPressed: () {
                                      BlocProvider.of<UserSignUpBloc>(context).add(ManualOtpCheckingEvent(otp: otpController.text));
                                    },
                                    child: state is ManualEmailCheckingLoadingState ? const CircularProgressIndicator() : Text(
                                      'Verify',
                                      style: Styles().elevatedButtonTextStyle(),
                                    )),
                              ),
                              // Text(
                              //   'resent OTP',
                              //   style: Styles().linkTextColorStyle(context),
                              // )
                            ],
                          ),
                        ],
                      );
                    },
                    listener: (context, state) {
                      if(state is ManualOtpCheckingSuccessState ){
                        print('++++++++++++++++++++++++++++');
                        print(BlocProvider.of<UserSignUpBloc>(context).email);
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return UserSignUpMoreInfo();
                        }));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
