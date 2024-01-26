import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/presentation/pages/userLogin/user_login_page.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Scaffold(
          body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 210, 212, 255),
            height: 300,
            child: Text(BlocProvider.of<UserLoginBloc>(context).userId!),
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
                  return  UserLogin();
                }), (route) => false);
              },
              child: const Text('Sign out'))
        ],
      )),
    ));
  }
}
