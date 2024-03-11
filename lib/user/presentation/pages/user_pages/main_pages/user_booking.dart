import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/room_booking_model.dart';
import 'package:share/user/presentation/widgets/room_booking_widget.dart';

class UserBookingPage extends StatelessWidget {
  const UserBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              context.watch<UserLoginBloc>().userId != null
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseFirestoreConst
                              .firebaseFireStoreUserCollection)
                          .doc(BlocProvider.of<UserLoginBloc>(context).userId)
                          .collection(FirebaseFirestoreConst
                              .firebaseFireStoreCurrentBookingAndPayAtHotelRoomCollection)
                          .orderBy(FirebaseFirestoreConst
                              .firebaseFireStoreBookingTime)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    'Pending payment',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                      snapshot.data!.docs.length, (index) {
                                    log('${snapshot.data!.docs[index].data()}');
                                    return snapshot.data!.docs[index][
                                                FirebaseFirestoreConst
                                                    .firebaseFireStorePaymentModel] ==
                                            null
                                        ? RoomBookingWidget()
                                            .bookingPendingRoom(
                                                roomBookingModel:
                                                    RoomBookingModel.fromMap(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .data()),
                                                context: context,
                                                bookingId: snapshot
                                                    .data!.docs[index].id)
                                        : const SizedBox();
                                  }),
                                ),
                              ],
                            );
                          } else {
                            return Text('nooo');
                          }
                        } else {
                          return Text('snapshort is empty');
                        }
                      },
                    )
                  : Text('No data'),
            ],
          ),
          Column(
            children: [
              context.watch<UserLoginBloc>().userId != null
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseFirestoreConst
                              .firebaseFireStoreUserCollection)
                          .doc(BlocProvider.of<UserLoginBloc>(context).userId)
                          .collection(FirebaseFirestoreConst
                              .firebaseFireStoreCurrentBookedRoomCollection)
                          .orderBy(FirebaseFirestoreConst
                              .firebaseFireStoreBookingTime)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    'Booking',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                      snapshot.data!.docs.length, (index) {
                                    return snapshot.data!.docs[index][
                                                FirebaseFirestoreConst
                                                    .firebaseFireStorePaymentModel] !=
                                            null
                                        ? RoomBookingWidget()
                                            .bookingConfirmedRoom(
                                                roomBookingModel:
                                                    RoomBookingModel.fromMap(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .data()),
                                                context: context)
                                        : const SizedBox();
                                  }),
                                ),
                              ],
                            );
                          } else {
                            return Text('nooo');
                          }
                        } else {
                          return Text('snapshort is empty');
                        }
                      },
                    )
                  : Text('No data'),
            ],
          ),
        ],
      ),
    ));
  }
}
