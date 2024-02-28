import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_event.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/user_function.dart';

class RoomBookingBloc extends Bloc<RoomBookingEvent, RoomBookingState> {
  DateTime? startingDate;
  DateTime? endingDate;
  Set<DateTime> unSelectedStartingDate = {};
  Set<DateTime> unSelectedEndingDate = {};

  RoomBookingBloc() : super(InitialRoomBookingState()) {
    on<OnSelectDateTime>((event, emit) async {
      emit(RoomBookingLoadingState());
      DocumentSnapshot<Map<String, dynamic>> instance = await FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .doc(event.roomId)
          .get();

      if (instance.data()![
              FirebaseFirestoreConst.firebaseFireStoreBookingDeatails] !=
          null) {
        if (instance
            .data()![FirebaseFirestoreConst.firebaseFireStoreBookingDeatails]
            .isNotEmpty) {
          for (Map<String, dynamic> bookedDate in instance.data()![
              FirebaseFirestoreConst.firebaseFireStoreBookingDeatails]) {
            log('${bookedDate[FirebaseFirestoreConst.firebaseFireStoreBookedDates]['start']}');
            for (DateTime i = DateTime.fromMillisecondsSinceEpoch(bookedDate[
                            FirebaseFirestoreConst
                                .firebaseFireStoreBookedDates]['start']
                        .seconds *
                    1000);
                i.isBefore(DateTime.fromMillisecondsSinceEpoch(bookedDate[
                            FirebaseFirestoreConst
                                .firebaseFireStoreBookedDates]['end']
                        .seconds *
                    1000));
                i = i.add(const Duration(days: 1))) {
              unSelectedStartingDate.add(i);
              unSelectedEndingDate.add(i.add(const Duration(days: 1)));
            }
          }
        } else {
          log('Dates are empty');
        }
      } else {
        log('Dates are null');
      }

      // make start date and ending date
      DateTime checkDate =
          UserFunction().removingTimeFromDatetime(dateTime: DateTime.now());
      while (unSelectedStartingDate.contains(checkDate)) {
        checkDate = checkDate.add(const Duration(days: 1));
      }
      startingDate = checkDate;
      endingDate = startingDate!.add(const Duration(days: 1));
      emit(RoomBookingDatePickedState());
    });
    on<OnClickStartingDate>((event, emit) {
      log('starting date is here');
      startingDate =
          UserFunction().removingTimeFromDatetime(dateTime: event.startDate);
      endingDate ??= startingDate;
      if (UserFunction()
              .removingTimeFromDatetime(dateTime: startingDate!)!
              .isAfter(UserFunction()
                  .removingTimeFromDatetime(dateTime: endingDate!)) ||
          UserFunction().removingTimeFromDatetime(dateTime: startingDate!) ==
              UserFunction().removingTimeFromDatetime(dateTime: endingDate!)) {
        endingDate = startingDate!.add(const Duration(days: 1));
      }
      DateTime checkDate = endingDate!;
      bool checkDateBool = false;
      while (event.startDate.isBefore(checkDate)) {
        if (unSelectedStartingDate.contains(checkDate)) {
          checkDateBool = true;
        }
        checkDate = checkDate.add(const Duration(days: -1));
      }
      if (checkDateBool) {
        endingDate = startingDate!.add(const Duration(days: 1));
      } else {
        emit(RoomBookingErrorState(
            text: 'Alredy Booked on these dates , please select another date'));
      }
      emit(RoomBookingStartingPickedState());
    });
    on<OnClickEndingDate>((event, emit) {
      if (UserFunction()
              .removingTimeFromDatetime(dateTime: event.endDate)
              .isAfter(
                UserFunction()
                    .removingTimeFromDatetime(dateTime: startingDate!)
                    .add(
                      const Duration(days: 1),
                    ),
              ) ||
          UserFunction().removingTimeFromDatetime(dateTime: event.endDate) ==
              UserFunction()
                  .removingTimeFromDatetime(dateTime: startingDate!)
                  .add(
                    const Duration(days: 1),
                  )) {
        DateTime checkDate = startingDate!.add(const Duration(days: 1));
        bool checkDateBool = false;
        while (checkDate.isBefore(event.endDate)) {
          if (unSelectedStartingDate.contains(checkDate)) {
            checkDateBool = true;
          }

          checkDate = checkDate.add(const Duration(days: 1));
        }
        if (!checkDateBool) {
          endingDate =
              UserFunction().removingTimeFromDatetime(dateTime: event.endDate);
        } else {
          emit(RoomBookingErrorState(
              text:
                  'Alredy Booked on these dates , please select another date'));
        }
      } else {
        emit(RoomBookingErrorState(
            text: 'Select a date after the selected starting date'));
      }
      emit(RoomBookingStartingPickedState());
    });
    on<OnClickRoomBookingPayButton>((event, emit) async {
      log('${event.roomBookingModel.toMap()}');

      // adding room booking deatails to the room stored page

      CollectionReference<Map<String, dynamic>> roomInstance = FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection);
      await roomInstance.doc(event.roomBookingModel.roomId).update({
        FirebaseFirestoreConst.firebaseFireStoreBookingDeatails:
            FieldValue.arrayUnion([event.roomBookingModel.toMap()])
      });
      // adding booking detailes to the user sub collection
      var userInstance = FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
      await userInstance
          .doc(event.roomBookingModel.userId)
          .collection(
              FirebaseFirestoreConst.firebaseFireStoreCurrentBookedRoomCollection)
          .add(event.roomBookingModel.toMap());
      log('vannne-----------------');
    });
  }
}
