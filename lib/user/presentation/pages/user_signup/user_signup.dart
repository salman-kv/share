import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_event.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_state.dart';
import 'package:share/user/presentation/pages/user_signup/user_signup_otp.dart';
import 'package:share/user/presentation/widgets/commen_widget.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class UserSignUp extends StatelessWidget {
   UserSignUp({super.key});

  TextEditingController emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        width: double.infinity,
        child: Column(
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
                    'Enter Your Email',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Form(
                child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: TextFormField(
                      controller: emailController,
                      decoration: Styles().formDecrationStyle(
                          icon: const Icon(Icons.mail_outline_rounded),
                          labelText: 'Email'),
                      style: Styles().formTextStyle(context),
                    ),
                  ),
                ),
                 SizedBox(height: MediaQuery.of(context).size.height >786 ? MediaQuery.of(context).size.height*0.63 : MediaQuery.of(context).size.height*.45 ,),
                BlocConsumer<UserSignUpBloc,UserSignUpState>(
                  builder: (context, state) {
                    return  Container(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: Styles().elevatedButtonDecration(),
                    child: ElevatedButton(
                        style: Styles().elevatedButtonStyle(),
                        onPressed: () {
                          BlocProvider.of<UserSignUpBloc>(context).add(ManualEmailCheckingEvent(email: emailController.text.toLowerCase().trim()));
                        },
                        child: state is ManualEmailCheckingLoadingState ? const CircularProgressIndicator(
                          color: Colors.white,
                        ) :  Text(
                          'verify',
                          style: Styles().elevatedButtonTextStyle(),
                        )),
                  );
                  },listener: (context, state) {
                    if(state is ManualEmailCheckingSuccessState){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                        return  UserSignUpOtp();
                      }));
                    }
                    else if(state is UserSignupErrorState){
                      CommonWidget().errorSnackBar('Invalid Email , pls enter a valid email', context);
                    }
                    else if(state is UserAlreadySignupErrorState){
                      CommonWidget().errorSnackBar('User alredy Logined', context);
                    }
                  },
                ),
              ],
            ))
          ],
        ),
      )),
    ));
  }
}
