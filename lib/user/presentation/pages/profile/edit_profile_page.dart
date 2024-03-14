import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/domain/functions/user_firestroe_funciton.dart';
import 'package:share/user/domain/functions/user_function.dart';
import 'package:share/user/domain/model/user_model.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  final nameKey = GlobalKey<FormFieldState>();

  final phoneKey = GlobalKey<FormFieldState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  String? image;
  @override
  void initState() {
    image = BlocProvider.of<UserLoginBloc>(context).userModel!.imagePath;
    nameController.text =
        BlocProvider.of<UserLoginBloc>(context).userModel!.name;
    phoneController.text =
        BlocProvider.of<UserLoginBloc>(context).userModel!.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLoginBloc, UserLoginState>(
     
      builder: (context, state) {
         if(state is UserDeatailsUpdatedState){
        image=state.image;
      }
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Text(
                  'Edit Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: TextFormField(
                              key: nameKey,
                              validator: (value) {
                                if ((!RegExp(r'^\S+(?!\d+$)')
                                    .hasMatch(value!))) {
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: TextFormField(
                              key: phoneKey,
                              onChanged: (value) {
                                phoneKey.currentState!.validate();
                              },
                              validator: (value) {
                                if ((!RegExp(r'^[0-9]+\.?[0-9]*$')
                                    .hasMatch(value!))) {
                                  return 'enter valid Phone number';
                                } else {
                                  return null;
                                }
                              },
                              controller: phoneController,
                              decoration: Styles().formDecrationStyle(
                                  icon:
                                      const Icon(Icons.phone_in_talk_outlined),
                                  labelText: 'Phone'),
                              style: Styles().formTextStyle(context),
                            ),
                          ),
                        ),
                       state is UserDeatailsUpdatingState ? Lottie.asset('assets/images/imageLoading.json') : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.height * 0.3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: Image.network(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              BlocProvider.of<UserLoginBloc>(context).add(OnImageUpdatingEvent());
                              
                            },
                            child: const Text('Change Profile'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: Styles().elevatedButtonDecration(),
                            child: ElevatedButton(
                                style: Styles().elevatedButtonStyle(),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    log('validation success');
                                    BlocProvider.of<UserLoginBloc>(context).add(
                                        OnProfileUpdatingState(
                                            userName: nameController.text,
                                            phone: phoneController.text,
                                            imagePath: image!));
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  'submit',
                                  style: Styles().elevatedButtonTextStyle(),
                                )),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
      },
    );
  }
}
