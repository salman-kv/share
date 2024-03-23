import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_state.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/room_booking_model.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/widgets/current_room_widgets.dart';

class UserCurrentPropertyPage extends StatelessWidget {
  const UserCurrentPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomBookingBloc(),
      child: BlocConsumer<RoomBookingBloc, RoomBookingState>(
        listener: (context, state) {
          if (state is RoomBookingEventSuccessState) {
            SnackBars().notifyingSnackBar(state.text, context);
          }
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
                if (snapshot.data!.docs.isNotEmpty) {
                  return ListView(
                    children:
                        List.generate(snapshot.data!.docs.length, (index) {
                      return CurrentRoomWidget().currentEnrolledRoomContainer(
                          context: context,
                          roomBookingModel: RoomBookingModel.fromMap(
                              snapshot.data!.docs[index].data()));
                    }),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Lottie.asset('assets/images/no current property.json'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('No current Enrolled Room',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),),
                      )
                    ],
                  );
                }
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
