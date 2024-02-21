
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_event.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/room_model.dart';

class SingleRoomBloc extends Bloc<SingleRoomEvent, SingleRoomState> {
  RoomModel? roomModel;
  SingleRoomBloc() : super(SingleRoomInitialState()) {
    on<OnInitialRoomDeatailsAddingEvent>((event, emit) async {
      log('ivde keraninde');
      DocumentSnapshot<Map<String, dynamic>> instance = await FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .doc(event.id)
          .get();
      roomModel=RoomModel.fromMap(instance.data()!, instance.id);
      emit(SingleRoomSuccessState());
    });
  }
}
