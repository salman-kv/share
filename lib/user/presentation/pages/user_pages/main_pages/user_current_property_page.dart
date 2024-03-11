import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_state.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/room_booking_model.dart';
import 'package:share/user/presentation/widgets/current_room_widgets.dart';

class UserCurrentPropertyPage extends StatelessWidget {
  const UserCurrentPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomBookingBloc(),
      child: BlocConsumer<RoomBookingBloc, RoomBookingState>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                    FirebaseFirestoreConst.firebaseFireStoreUserCollection)
                .doc(context.read<UserLoginBloc>().userId)
                .collection(
                    FirebaseFirestoreConst.firebaseFireStoreCurrentUserRoom)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    log('${snapshot.data!.docs[index].data()}');
                    return CurrentRoomWidget().currentEnrolledRoomContainer(
                        context: context,
                        roomBookingModel: RoomBookingModel.fromMap(
                            snapshot.data!.docs[index].data()));
                  }),
                );
              } else {
                return Text('no room now');
              }
            },
          );
        },
      ),
    );
  }
}
