import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/domain/repository/google_user_auth.dart';
import 'package:share/user/presentation/pages/user_signup/user_signup_more.dart';
import 'package:share/user/presentation/widgets/buttons.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                          decoration: Styles().formDecrationStyle(
                              icon: const Icon(Icons.mail_outlined),
                              labelText: 'Email'),
                          style: Styles().formTextStyle(),
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
                          obscureText: true,
                          decoration: Styles().formDecrationStyle(
                              icon: const Icon(Icons.lock_outline_rounded),
                              labelText: 'Password'),
                          style: Styles().formTextStyle(),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot password?',
                        style: Styles().passwordTextStyle(),
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
              Container(
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: Styles().elevatedButtonDecration(),
                child: ElevatedButton(
                    style: Styles().elevatedButtonStyle(),
                    onPressed: () {},
                    child: Text(
                      'Login',
                      style: Styles().elevatedButtonTextStyle(),
                    )),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        var data = await UserAuthFunction().signInWithGoogle();
                        if(data != null){
                          
                          Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return const UserSignUpMoreInfo();
                        }));
                        }
                        // ignore: use_build_context_synchronously
                        
                      },
                      child: CustomButton().loginIconButton(),
                    )
                  ],
                ),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Don't have an account yet?",
                    style: Theme.of(context).textTheme.displaySmall),
                TextSpan(
                    text: ' Register',
                    style: Styles().linkTextColorStyle(context))
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
