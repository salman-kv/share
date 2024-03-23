import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/presentation/pages/main_page.dart';
import 'package:share/user/presentation/pages/userLogin/user_login_page.dart';
import 'package:share/user/presentation/pages/welcomeUser/user_welcome_user.dart';

class SplashScreen extends StatelessWidget {
  final String? userId;
  const SplashScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (userId == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) {
          return const WelcomeUser();
        }), (route) => false);
      } else if (userId == '') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) {
          return UserLogin();
        }), (route) => false);
      } else {
        BlocProvider.of<UserLoginBloc>(context)
            .add(UserDeatailesAddingEvent(userId: userId!,context: context));
      }
    });
    return SafeArea(
        child: Scaffold(
      body: BlocConsumer<UserLoginBloc, UserLoginState>(
        listener: (context, state) {
          if (state is UserLoginSuccessState) {
            log('state success');   
            Navigator.of(context).pushAndRemoveUntil( 
                MaterialPageRoute(builder: (ctx) {
              return MainPage();
            }), (route) => false);
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/images/splashScreenAnimation.json'),
            ],
          );
        },
      ),
    ));
  }
}
