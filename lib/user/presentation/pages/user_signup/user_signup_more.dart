
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_event.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/user_model.dart';
import 'package:share/user/domain/repository/user_function.dart';
import 'package:share/user/presentation/pages/user_pages/user_home.dart';
import 'package:share/user/presentation/widgets/styles.dart';

// ignore: must_be_immutable
class UserSignUpMoreInfo extends StatelessWidget {
  UserSignUpMoreInfo({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      "Let's Complete Your profile",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'It will help us to know more about you!,',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: TextFormField(
                    controller: nameController,
                    decoration: Styles().formDecrationStyle(
                        icon: const Icon(Icons.person_2_sharp),
                        labelText: 'Name'),
                    style: Styles().formTextStyle(),
                  ),
                ),
              ),
              // DropdownButtonHideUnderline(
              //   child: DropdownButton2(
              //     dropdownStyleData: DropdownStyleData(
              //       maxHeight: 300,
              //       width: MediaQuery.of(context).size.width * 0.9,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(14),
              //       ),
              //     ),
              //     buttonStyleData: ButtonStyleData(
              //       height: 55,
              //       width: MediaQuery.of(context).size.width * 0.92,
              //       padding: const EdgeInsets.only(left: 14, right: 14),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(14),
              //         color: const Color.fromARGB(255, 242, 242, 242),
              //       ),
              //     ),
              //     onChanged: (value) {},
              //     hint: const Row(
              //       children: [
              //         Icon(Icons.male_outlined),
              //         SizedBox(
              //           width: 5,
              //         ),
              //         Text('Gender'),
              //       ],
              //     ),
              //     items: const [
              //       DropdownMenuItem(
              //         value: 'Male',
              //         child: Text('Male'),
              //       ),
              //       DropdownMenuItem(
              //         value: 'Female',
              //         child: Text('Female'),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: Styles().formDecrationStyle(
                        icon: const Icon(Icons.phone_in_talk_outlined),
                        labelText: 'Phone'),
                    style: Styles().formTextStyle(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: Styles().formDecrationStyle(
                        icon: const Icon(Icons.lock_outline_rounded),
                        labelText: 'Password'),
                    style: Styles().formTextStyle(),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ElevatedButton(
                onPressed: () async {
                  String tempImage = await UserFunction().userPickImage();
                  // ignore: use_build_context_synchronously
                  BlocProvider.of<UserSignUpBloc>(context)
                      .add(OnAddUserSignUpImage(image: tempImage));
                },
                child: const Text('Add Image'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              BlocConsumer<UserSignUpBloc, UserSignUpState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.6),
                          image: context.read<UserSignUpBloc>().image != null
                              ? DecorationImage(
                                  image: FileImage(File(
                                      context.watch<UserSignUpBloc>().image!)),
                                  fit: BoxFit.cover)
                              : const DecorationImage(
                                  image:
                                      AssetImage('assets/images/profile.png')),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: Styles().elevatedButtonDecration(),
                        child: ElevatedButton(
                            style: Styles().elevatedButtonStyle(),
                            onPressed: () async {
                               BlocProvider.of<UserSignUpBloc>(context).add(
                                  OnVarifyUserDetailsEvent(
                                      userModel: UserModel(
                                          email: context
                                              .read<UserSignUpBloc>()
                                              .email!,
                                          name: nameController.text,
                                          password: passwordController.text,
                                          phone:
                                              int.parse(phoneController.text),
                                          imagePath: context
                                              .read<UserSignUpBloc>()
                                              .image!, userId: ''),
                                      compire: FirebaseFirestoreConst()
                                          .firebaseFireStoreEmail));
                            },
                            child: Text(
                              'Verify',
                              style: Styles().elevatedButtonTextStyle(),
                            )),
                      ),
                    ],
                  );
                },
                listener: (context, state) {
                  if (state is UserVerifiedWithMoredataState){
                    context.read<UserLoginBloc>().add(UserAlredyLoginEvent(userCredential:state.userCredential,userId: state.userId));
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const UserHome();
                    }));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
