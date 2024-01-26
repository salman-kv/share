import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/firebase_options.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_bloc.dart';
import 'package:share/user/presentation/pages/user_signup/user_signup.dart';
import 'package:share/user/presentation/pages/welcomeUser/user_welcome_user.dart';
import 'package:share/user/presentation/theme/user_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
        home: const WelcomeUser(),
        // home: const UserSignUpMoreInfo(),
      ),
    );
  }
}
