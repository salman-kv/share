import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/firebase_options.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_bloc.dart';
import 'package:share/user/domain/functions/shared_prefrence.dart';
import 'package:share/user/presentation/pages/userLogin/user_login_page.dart';
import 'package:share/user/presentation/pages/user_pages/user_home.dart';
import 'package:share/user/presentation/pages/welcomeUser/user_welcome_user.dart';
import 'package:share/user/presentation/theme/user_theme.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final String? loginStatus=await SharedPreferencesClass.getUserId();
  runApp( MainApp(loginStatus: loginStatus,));
}

class MainApp extends StatelessWidget {
  final String? loginStatus;
   const MainApp({super.key,required this.loginStatus});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return UserLoginBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return UserSignUpBloc();
          },
        ),
      ],
      child: MaterialApp(
        theme: UserTheme().lightTheme,
        darkTheme: UserTheme().darkTheme,
        debugShowCheckedModeBanner: false,
        home:  loginStatus == '' ? UserLogin() : loginStatus != null? UserHome() : const WelcomeUser() ,
      ),
    );
  }
}
