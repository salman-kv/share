import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share/user/domain/model/user_model.dart';
import 'package:share/user/domain/functions/shared_prefrence.dart';
import 'package:share/user/domain/functions/user_function.dart';
import 'package:share/user/presentation/pages/userLogin/user_login_page.dart';

class UserHome extends StatelessWidget {
  UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Scaffold(
                body: FutureBuilder(
                    future: SharedPreferencesClass.getUserId(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return FutureBuilder(
                          future: UserFunction()
                              .fecchUserDataById(snapshot.data.toString()),
                          builder: (context, snap) {
                            if (snap.hasData) {
                              final userModel = snap.data as UserModel;
                              return Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 234, 227, 188),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image:NetworkImage(userModel.imagePath),fit:BoxFit.cover),
                                          borderRadius: BorderRadius.circular(1000)
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'NAME : ${userModel.name}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        'EMAIL : ${userModel.email}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        'PHONE : ${userModel.phone}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await FirebaseAuth.instance
                                                .signOut();
                                            await GoogleSignIn().signOut();
                                            SharedPreferencesClass.deleteUserid();
                                            SharedPreferencesClass.deleteUserEmail();
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (ctx) {
                                              return UserLogin();
                                            }), (route) => false);
                                          },
                                          child: const Text('Sign out'))
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              // CommonWidget().toastWidget('errrrror');
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      } else {
                        // CommonWidget().toastWidget('errrrror2222222222222');
                        return const Center(child: CircularProgressIndicator());
                      }
                    })
                // body: Column(
                // children: [
                // Container(
                //   color: const Color.fromARGB(255, 210, 212, 255),
                //   height: 300,
                //   child: const Text('user Logined sucess'),
                // ),
                // FutureBuilder(
                //   future: SharedPreferencesClass.getUserEmail(),
                //   builder: (context, snapshot) {
                //     return Text(snapshot.data.toString());
                //   },
                // ),
                // FutureBuilder(
                //   future: SharedPreferencesClass.getUserId(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       print(snapshot.data.toString());
                //       UserFunction().fecchUserDataById(snapshot.data.toString());
                //        return Text(snapshot.data.toString());
                //     }
                //     else{
                //       return Text('no data');
                //     }

                //   },
                // ),
                // Text(userId),

                // ],
                // )),
                // ));
                )));
  }
}
