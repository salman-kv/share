
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/firebase_options.dart';
import 'package:share/user/aplication/filter_bloc/filter_bloc.dart';
import 'package:share/user/aplication/main_user_bloc/main_user_bloc.dart';
import 'package:share/user/aplication/main_user_bloc/main_user_state.dart';
import 'package:share/user/aplication/notification_bloc/notification_bloc.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_bloc.dart';
import 'package:share/user/aplication/search_bloc/search_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_bloc.dart';
import 'package:share/user/domain/functions/shared_prefrence.dart';
import 'package:share/user/presentation/const/const_color.dart';

import 'package:share/user/presentation/splash_screen/splash_screen.dart';
import 'package:share/user/presentation/theme/user_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final String? loginStatus = await SharedPreferencesClass.getUserId();
  final int? colorIndex = await SharedPreferencesClass.getColorIndex();
  await ConstColor().changeColor(index: colorIndex ?? 0);
  runApp(MainApp(
    loginStatus: loginStatus,
    colorIndex: colorIndex,
  ));
}

class MainApp extends StatelessWidget {
  final String? loginStatus;
  final int? colorIndex;
  const MainApp(
      {required this.colorIndex, super.key, required this.loginStatus});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return UserLoginBloc();
          },
        ),
        BlocProvider(create: (context) {
          return SearchBloc();
        }),
        BlocProvider(
          create: (context) {
            return UserSignUpBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return FilterBloc();
          },
        ),
        BlocProvider(
          create: (context) => MainUserBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => RoomBookingBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => RatingAndFeedbackBloc(),
          child: Container(),
        )
      ],
      child: BlocBuilder<MainUserBloc, MainUserState>(
        builder: (context, state) {
          return MaterialApp(
            theme: UserTheme().lightTheme,
            darkTheme: UserTheme().darkTheme,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(userId: loginStatus),
          );
        },
      ),
    );
  }
}
