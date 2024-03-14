import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/room_booking_model.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';

import 'package:share/user/presentation/widgets/room_booking_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'History',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              centerTitle: true,
            ),
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                      FirebaseFirestoreConst.firebaseFireStoreUserCollection)
                  .doc(BlocProvider.of<UserLoginBloc>(context).userId)
                  .collection(
                      FirebaseFirestoreConst.firebaseFireStoreBookingHistory)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView(
                      children:
                          List.generate(snapshot.data!.docs.length, (index) {
                        return RoomBookingWidget().historyRoomContainer(
                            roomBookingModel: RoomBookingModel.fromMap(
                                snapshot.data!.docs[index].data()),
                            context: context);
                      }),
                    );
                  } else {
                    return CommonWidget()
                        .noDataWidget(text: 'No History now', context: context);
                  }
                } else {
                  return const SizedBox();
                }
              },
            )));
  }
}
