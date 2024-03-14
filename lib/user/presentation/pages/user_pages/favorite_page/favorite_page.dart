import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/room_model.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Favorite',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
          ),
          body: BlocConsumer<UserLoginBloc, UserLoginState>(
            listener: (context, state) {},
            builder: (context, state) {
              return BlocProvider.of<UserLoginBloc>(context)
                      .favoriteRooms
                      .isEmpty
                  ? CommonWidget()
                      .noDataWidget(text: 'No favorite', context: context)
                  : ListView(
                      children: List.generate(
                          BlocProvider.of<UserLoginBloc>(context)
                              .favoriteRooms
                              .length, (index) {
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(FirebaseFirestoreConst
                                  .firebaseFireStoreRoomCollection)
                              .doc(BlocProvider.of<UserLoginBloc>(context)
                                  .favoriteRooms[index])
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              log('${snapshot.data!.data()}');
                              return CommonWidget().roomShowingContainer(
                                  context: context,
                                  roomModel: RoomModel.fromMap(
                                      snapshot.data!.data()!,
                                      BlocProvider.of<UserLoginBloc>(context)
                                          .favoriteRooms[index]));
                            } else {
                              return const Text('no room');
                            }
                          },
                        );
                      }),
                    );
            },
          )),
    );
  }
}
