import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/hotel_bloc/hotel_event.dart';
import 'package:share/user/aplication/hotel_bloc/hotel_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/main_property_model.dart';
import 'package:share/user/domain/model/room_model.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  String hotelId;
  List<RoomModel> listRoomModel = [];
  MainPropertyModel? mainPropertyModel;
  HotelBloc({required this.hotelId}) : super(HotelInitialState()) {
    on((event, emit) async {
      emit(HotelLoadingState());
      DocumentSnapshot<Map<String, dynamic>> instance = await FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
          .doc(hotelId)
          .get();
      mainPropertyModel =
          MainPropertyModel.fromMap(instance.data()!, instance.id);
          var instanceOfRoom = FirebaseFirestore.instance
            .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection);
         for (dynamic i in mainPropertyModel!.rooms) {
          await instanceOfRoom.doc(i).get().then(
            (value) {
              listRoomModel.add(
                RoomModel.fromMap(value.data()!, value.id),
                
              );
            },
          );
        }
        log('${listRoomModel}');
        log('room done');
      emit(HotelSuccessState());
    });
  }
}
