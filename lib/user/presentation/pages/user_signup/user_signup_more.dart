import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_bloc.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_event.dart';
import 'package:share/user/aplication/user_signup_bloc/user_signup_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/user_firestroe_funciton.dart';
import 'package:share/user/domain/model/user_model.dart';
import 'package:share/user/domain/functions/user_function.dart';
import 'package:share/user/presentation/alerts/toasts.dart';
import 'package:share/user/presentation/pages/user_signup/user_signup_success.dart';
import 'package:share/user/presentation/widgets/styles.dart';

// ignore: must_be_immutable
class UserSignUpMoreInfo extends StatelessWidget {
  UserSignUpMoreInfo({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormFieldState>();
  final phoneKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PopScope(
        canPop: true,
         onPopInvoked: (didPop) {
           GoogleSignIn().signOut();
         },
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
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
                        key: nameKey,
                        validator: (value) {
                          if ((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!))) {
                            return 'enter valid name';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          nameKey.currentState!.validate();
                        },
                        controller: nameController,
                        decoration: Styles().formDecrationStyle(
                            icon: const Icon(Icons.person_2_sharp),
                            labelText: 'Name'),
                        style: Styles().formTextStyle(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: TextFormField(
                        key: phoneKey,
                        onChanged: (value) {
                          phoneKey.currentState!.validate();
                        },
                        validator: (value) {
                          if ((!RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(value!))) {
                            return 'enter valid Phone number';
                          } else {
                            return null;
                          }
                        },
                        controller: phoneController,
                        decoration: Styles().formDecrationStyle(
                            icon: const Icon(Icons.phone_in_talk_outlined),
                            labelText: 'Phone'),
                        style: Styles().formTextStyle(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: TextFormField(
                        key: passwordKey,
                        onChanged: (value) {
                          passwordKey.currentState!.validate();
                        },
                        validator: (value) {
                          if ((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!))) {
                            return 'enter valid password';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: Styles().formDecrationStyle(
                            icon: const Icon(Icons.lock_outline_rounded),
                            labelText: 'Password'),
                        style: Styles().formTextStyle(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      XFile tempImage = await UserFunction().userPickImage();
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
                                      image: FileImage(File(context
                                          .watch<UserSignUpBloc>()
                                          .image!
                                          .path)),
                                      fit: BoxFit.cover)
                                  : const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/profile.png')),
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
                                  if (BlocProvider.of<UserSignUpBloc>(context)
                                          .image ==
                                      null) {
                                    Toasts()
                                        .toastWidget('pls add profile photo');
                                    return;
                                  } else if (formKey.currentState!.validate()) {
                                    log('validate successfull');
                                    BlocProvider.of<UserSignUpBloc>(context)
                                        .add(OnlyForLoadingevent());
                                    final imageUrl = await UserFireStroreFunction()
                                        .uploadImageToFirebase(context
                                            .read<UserSignUpBloc>()
                                            .image!);
                                    // ignore: use_build_context_synchronously
                                    BlocProvider.of<UserSignUpBloc>(context).add(
                                        OnVarifyUserDetailsEvent(
                                            userModel: UserModel(
                                                // ignore: use_build_context_synchronously
                                                email: context
                                                    .read<UserSignUpBloc>()
                                                    .email!,
                                                name: nameController.text,
                                                password: passwordController.text,
                                                phone: int.parse(
                                                    phoneController.text),
                                                imagePath: imageUrl,
                                                userId: ''),
                                            compire: FirebaseFirestoreConst
                                                .firebaseFireStoreEmail));
                                    // ignore: use_build_context_synchronously
                                  }
                                },
                                child: state is UserSignupLoading
                                    ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : Text(
                                        'Submit',
                                        style: Styles().elevatedButtonTextStyle(),
                                      )),
                          ),
                        ],
                      );
                    },
                    listener: (context, state) {
                      if (state is UserVerifiedWithMoredataState) {
                        context.read<UserLoginBloc>().add(UserAlredyLoginEvent(
                            userCredential: state.userCredential,
                            userId: state.userId));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (ctx) {
                          return const UserSignUpsuccess();
                        }), (route) => false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
