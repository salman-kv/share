import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_event.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_state.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/pages/main_page.dart';
import 'package:share/user/presentation/pages/user_signup/user_signup.dart';
import 'package:share/user/presentation/pages/user_signup/user_signup_more.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class UserLogin extends StatelessWidget {
  UserLogin({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<UserSignUpBloc, UserSignUpState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          'Hey there,',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Welcome Back',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: TextFormField(

                              controller: emailController,
                              decoration: Styles().formDecrationStyle(
                                  icon: const Icon(Icons.mail_outlined),
                                  labelText: 'Email'),
                              style: Styles().formTextStyle(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: Styles().formDecrationStyle(
                                  icon: const Icon(Icons.lock_outline_rounded),
                                  labelText: 'Password'),
                              style: Styles().formTextStyle(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height > 786
                        ? MediaQuery.of(context).size.height * 0.44
                        : MediaQuery.of(context).size.height * .3,
                  ),
                  BlocConsumer<UserLoginBloc, UserLoginState>(
                    builder: (context, state) {
                      if (state is UserLoginLoadingState) {
                        return const CircularProgressIndicator();
                      }
                      return Container(
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: Styles().elevatedButtonDecration(),
                        child: ElevatedButton(
                            style: Styles().elevatedButtonStyle(),
                            onPressed: () {
                              context.read<UserLoginBloc>().add(
                                  UserLoginLoadingEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim()));
                            },
                            child: Text(
                              'Login',
                              style: Styles().elevatedButtonTextStyle(),
                            )),
                      );
                    },
                    listener: (context, state) {
                      if (state is UserLoginSuccessState) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (ctx) {
                          return MainPage();
                        }), (route) => false);
                      }
                      else if(state is UserLoginErrorState){
                        SnackBars().errorSnackBar('Invalid username or password', context);
                      }
                      else if(state is UserDeatailedAddigPendingState){
                        BlocProvider.of<UserLoginBloc>(context).add(UserDeatailesAddingEvent(userId: BlocProvider.of<UserLoginBloc>(context).userId!,context: context));
                      }
                    },
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Divider(
                            thickness: 3,
                          ),
                        ),
                      ),
                      Text(
                        "Or",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Divider(
                            thickness: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: state is UserSignupLoading
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .read<UserSignUpBloc>()
                                      .add(OnclickUserSignUpAuthentication());
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration:
                                      Styles().googleAuthButtonDecration(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child:
                                        Image.asset('assets/images/google.png'),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return UserSignUp();
                      }));
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Don't have an account yet?",
                          style: Theme.of(context).textTheme.displaySmall),
                      TextSpan(
                          text: ' Register',
                          style: Styles().linkTextColorStyle(context))
                    ])),
                  )
                ],
              );
            },
            listener: (context, state) {
              if (state is UserAlredySignupState) {
                context.read<UserLoginBloc>().add(UserAlredyLoginEvent(
                    userCredential: state.userCredential,
                    userId: state.userId));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) {
                  return MainPage();
                }), (route) => false);
              } else if (state is UserSignupAuthenticationSuccess) {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                  return UserSignUpMoreInfo();
                }));
              }
              // else if()
            },
          ),
        ),
      ),
    );
  }
}
