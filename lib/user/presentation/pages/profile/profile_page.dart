import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/main_user_bloc/main_user_bloc.dart';
import 'package:share/user/aplication/main_user_bloc/main_user_event.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/domain/functions/user_function.dart';
import 'package:share/user/presentation/const/const_color.dart';
import 'package:share/user/presentation/pages/profile/edit_profile_page.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLoginBloc, UserLoginState>(
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
                appBar: AppBar(),
                body: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.65,
                        decoration: BoxDecoration(
                            color: ConstColor().mainColorblue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * (.13),
                            ),
                            Text(
                              BlocProvider.of<UserLoginBloc>(context)
                                  .userModel!
                                  .name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    BlocProvider.of<UserLoginBloc>(context)
                                        .userModel!
                                        .email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  Text(
                                    BlocProvider.of<UserLoginBloc>(context)
                                        .userModel!
                                        .phone,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              decoration: Styles().elevatedButtonDecration(),
                              child: ElevatedButton(
                                style: Styles().elevatedButtonStyle(),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return EditProfilePage();
                                    },
                                  ));
                                },
                                child: Text(
                                  'Edit profile',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.dark
                                        ? Colors.black
                                        : Colors.white,
                                width: 20,
                                strokeAlign: BorderSide.strokeAlignOutside),
                            borderRadius: BorderRadius.circular(1000)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: CommonWidget().profileNetworkImage(
                              context: context,
                              image: BlocProvider.of<UserLoginBloc>(context)
                                  .userModel!
                                  .imagePath,
                            )),
                      ),
                    ),
                    // ElevatedButton(onPressed: (){
                    //   BlocProvider.of<MainUserBloc>(context).add(OnColorChangeEvent());
                    // }, child: Text('color'))
                  ],
                )));
      },
    );
  }
}
