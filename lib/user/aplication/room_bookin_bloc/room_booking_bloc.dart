import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_event.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/notification_function.dart';
import 'package:share/user/domain/functions/user_function.dart';
import 'package:share/user/domain/model/checkin_checkout_model.dart';
import 'package:share/user/domain/model/notification_model.dart';
import 'package:share/user/presentation/alerts/alert.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/pages/payment_page/payment_page.dart';

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
          if (instance
                  .data()![FirebaseFirestoreConst.firebaseFireStoreHotelType] ==
              'HotelType.hotel') {
            log('hotel');
            for (Map<String, dynamic> bookedDate in instance.data()![
                FirebaseFirestoreConst.firebaseFireStoreBookingDeatails]) {
              log('${bookedDate[FirebaseFirestoreConst.firebaseFireStoreBookedDates]}');
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
                log('adding date');
                unSelectedStartingDate.add(i);
                unSelectedEndingDate.add(i.add(const Duration(days: 1)));
              }
            }
          } else {
            log('dormetory');
            Map<DateTime, int> countingMap = {};
            for (Map<String, dynamic> bookedDate in instance.data()![
                FirebaseFirestoreConst.firebaseFireStoreBookingDeatails]) {
              log('${bookedDate[FirebaseFirestoreConst.firebaseFireStoreBookedDates]}');
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
                countingMap[i] = (countingMap[i] ?? 0) + 1;
              }
            }
            for (var val in countingMap.keys) {
              if (countingMap[val] ==
                  instance.data()![
                      FirebaseFirestoreConst.firebaseFireStoreNumberOfBed]) {
                unSelectedStartingDate.add(val);
                unSelectedEndingDate.add(
                  val.add(
                    const Duration(days: 1),
                  ),
                );
              }
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
        }
      }
      emit(RoomBookingStartingPickedState());
    });
    on<OnClickRoomBookingPayButton>((event, emit) async {
      emit(RoomBookingLoadingState());
      // add money to the subadmin wallet
      await FirebaseFirestore.instance
          .collection(
              FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
          .get()
          .then((value) async {
        for (var i in value.docs) {
          if (i.data().containsKey('hotel')) {
            if (i.data()['hotel'].contains(event.roomBookingModel.hotelId)) {
              var subAdminData = await FirebaseFirestore.instance
                  .collection(FirebaseFirestoreConst
                      .firebaseFireStoreSubAdminCollection)
                  .doc(i.id)
                  .get();
              // add to notification
              NotificationModel notificationModel = NotificationModel(
                  opened: false,
                  notificationTime: DateTime.now(),
                  notificationPurpose: 'Room Booked',
                  notificationData: 'Room booked and pay via online',
                  roomBookingModel: event.roomBookingModel);
              await FirebaseFirestore.instance
                  .collection(FirebaseFirestoreConst
                      .firebaseFireStoreSubAdminCollection)
                  .doc(i.id)
                  .collection(
                      FirebaseFirestoreConst.firebaseFireStoreNotification)
                  .add(notificationModel.toMap());
              //
              if (subAdminData.data()!.containsKey("walletPrice")) {
                await FirebaseFirestore.instance
                    .collection(FirebaseFirestoreConst
                        .firebaseFireStoreSubAdminCollection)
                    .doc(i.id)
                    .update({
                  "walletPrice":
                      subAdminData["walletPrice"] + event.roomBookingModel.price
                });
              } else {
                await FirebaseFirestore.instance
                    .collection(FirebaseFirestoreConst
                        .firebaseFireStoreSubAdminCollection)
                    .doc(i.id)
                    .update({"walletPrice": event.roomBookingModel.price});
              }
            }
          }
        }
      });

      // adding booking detailes to the user sub collection
      var userInstance = FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
      var result = await userInstance
          .doc(event.roomBookingModel.userId)
          .collection(FirebaseFirestoreConst
              .firebaseFireStoreCurrentBookedRoomCollection)
          .add(event.roomBookingModel.toMap());
      event.roomBookingModel.bookingId = result.id;
      await userInstance
          .doc(event.roomBookingModel.userId)
          .collection(FirebaseFirestoreConst
              .firebaseFireStoreCurrentBookedRoomCollection)
          .doc(result.id)
          .update(event.roomBookingModel.toMap());
      // adding room booking deatails to the room stored page
      CollectionReference<Map<String, dynamic>> roomInstance = FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection);
      await roomInstance.doc(event.roomBookingModel.roomId).update({
        FirebaseFirestoreConst.firebaseFireStoreBookingDeatails:
            FieldValue.arrayUnion([event.roomBookingModel.toMap()])
      });
      log('addeed successs');
      startingDate = null;
      endingDate = null;
      emit(RoomBookingSuccessState());
      log('vannne-----------------');
    });
    on<OnClickRoomBookingAndPayAtHotel>((event, emit) async {
      emit(RoomBookingLoadingState());
      // add notification
      await NotificationFunction().notificationFunction(
          roomBookingModel: event.roomBookingModel,
          notificationPurpose: 'Room Booking',
          notificationData: 'Room booked Without payment');

      // adding booking detailes to the user sub collection
      var userInstance = FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
      var result = await userInstance
          .doc(event.roomBookingModel.userId)
          .collection(FirebaseFirestoreConst
              .firebaseFireStoreCurrentBookingAndPayAtHotelRoomCollection)
          .add(event.roomBookingModel.toMap());
      event.roomBookingModel.bookingId = result.id;
      await userInstance
          .doc(event.roomBookingModel.userId)
          .collection(FirebaseFirestoreConst
              .firebaseFireStoreCurrentBookingAndPayAtHotelRoomCollection)
          .doc(result.id)
          .update(event.roomBookingModel.toMap());
      // adding room booking deatails to the room stored page
      CollectionReference<Map<String, dynamic>> roomInstance = FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection);
      await roomInstance.doc(event.roomBookingModel.roomId).update({
        FirebaseFirestoreConst.firebaseFireStoreBookingDeatails:
            FieldValue.arrayUnion([event.roomBookingModel.toMap()])
      });
      log('addeed successs');
      startingDate = null;
      endingDate = null;
      emit(RoomBookingSuccessState());
    });
    on<OnCheckInClicked>((event, emit) async {
      // check in notification
      await NotificationFunction().notificationFunction(
          roomBookingModel: event.roomBookingModel,
          notificationPurpose: 'Check in request',
          notificationData: 'Check in request send by user');

      // updating checkincheckout on user side
      var userInstance = FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
      await userInstance
          .doc(event.roomBookingModel.userId)
          .collection(FirebaseFirestoreConst
              .firebaseFireStoreCurrentBookedRoomCollection)
          .doc(event.roomBookingModel.bookingId)
          .update({
        FirebaseFirestoreConst.firebaseFireStoreCheckInORcheckOutDeatails:
            event.checkInCheckOutModel.toMap()
      });
      CollectionReference<Map<String, dynamic>> roomInstance = FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection);
      DocumentSnapshot<Map<String, dynamic>> data =
          await roomInstance.doc(event.roomBookingModel.roomId).get();
      if (data.data()!.isNotEmpty) {
        List<dynamic> list = data
            .data()![FirebaseFirestoreConst.firebaseFireStoreBookingDeatails];
        log('${list.length}');
        for (int i = 0; i < list.length; i++) {
          if (list[i][FirebaseFirestoreConst.firebaseFireStoreBookingId] ==
              event.roomBookingModel.bookingId) {
            log('booking id is same');
            list.removeAt(i);
            break;
          }
        }
        log('${list.length}----------------');
        event.roomBookingModel.checkInCheckOutModel =
            event.checkInCheckOutModel;
        list.add(event.roomBookingModel.toMap());
        log('${list.length}');
        await roomInstance.doc(event.roomBookingModel.roomId).update(
            {FirebaseFirestoreConst.firebaseFireStoreBookingDeatails: list});
      }
      emit(RoomBookingEventSuccessState(text: 'Check In request sended'));
    });
    on<OnCheckOutClicked>((event, emit) async {
      emit(RoomBookingLoadingState());
      // check out notification
      await NotificationFunction().notificationFunction(
          roomBookingModel: event.roomBookingModel,
          notificationPurpose: 'Check out request',
          notificationData: 'Check out request send by user');

      // updating checkincheckout to checkoutwaiting on user side
      var userInstance = FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
      var data = await userInstance
          .doc(event.roomBookingModel.userId)
          .collection(FirebaseFirestoreConst.firebaseFireStoreCurrentUserRoom)
          .where(FirebaseFirestoreConst.firebaseFireStoreBookingId,
              isEqualTo: event.roomBookingModel.bookingId)
          .get();
      CheckInCheckOutModel checkInCheckOutModel = CheckInCheckOutModel.fromMap(
          data.docs[0].data()[FirebaseFirestoreConst
              .firebaseFireStoreCheckInORcheckOutDeatails]);
      checkInCheckOutModel.request = FirebaseFirestoreConst
          .firebaseFireStoreCheckInORcheckOutRequestForCheckOutWaiting;
      // updating the new checkincheckout model
      await userInstance
          .doc(event.roomBookingModel.userId)
          .collection(FirebaseFirestoreConst.firebaseFireStoreCurrentUserRoom)
          .doc(data.docs[0].id)
          .update({
        FirebaseFirestoreConst.firebaseFireStoreCheckInORcheckOutDeatails:
            checkInCheckOutModel.toMap()
      });
      //
      var currentUserCheckInRoom = await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .doc(event.roomBookingModel.roomId)
          .collection(
              FirebaseFirestoreConst.firebaseFireStoreCurrentUserCheckInRoom)
          .where(FirebaseFirestoreConst.firebaseFireStoreBookingId,
              isEqualTo: event.roomBookingModel.bookingId)
          .get();
      var currentUserCheckInRoomId = currentUserCheckInRoom.docs[0].id;
      await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .doc(event.roomBookingModel.roomId)
          .collection(
              FirebaseFirestoreConst.firebaseFireStoreCurrentUserCheckInRoom)
          .doc(currentUserCheckInRoomId)
          .update({
        FirebaseFirestoreConst.firebaseFireStoreCheckInORcheckOutDeatails:
            checkInCheckOutModel.toMap()
      });
      // change data from the bookingdeatails in room
      var roomInstance = await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .doc(event.roomBookingModel.roomId)
          .get();
      List<dynamic> list = roomInstance
          .data()![FirebaseFirestoreConst.firebaseFireStoreBookingDeatails];
      // remove old data and ad new changed data
      for (int i = 0;
          i <
              roomInstance
                  .data()![
                      FirebaseFirestoreConst.firebaseFireStoreBookingDeatails]
                  .length;
          i++) {
        if (list[i][FirebaseFirestoreConst.firebaseFireStoreBookingId] ==
            event.roomBookingModel.bookingId) {
          list.removeAt(i);
          break;
        }
      }
      event.roomBookingModel.checkInCheckOutModel!.request =
          FirebaseFirestoreConst
              .firebaseFireStoreCheckInORcheckOutRequestForCheckOutWaiting;
      list.add(event.roomBookingModel.toMap());
      // updating to the room
      await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .doc(event.roomBookingModel.roomId)
          .update(
              {FirebaseFirestoreConst.firebaseFireStoreBookingDeatails: list});
      emit(RoomBookingEventSuccessState(
          text: 'checkout request send successfully'));
    });
    on<OnDeleateRoomBooking>((event, emit) async {
      // add notification
      await NotificationFunction().notificationFunction(
          roomBookingModel: event.roomBookingModel,
          notificationPurpose: 'Room booking canceled',
          notificationData: 'Room booking canceled by user');

      // cancel room booking
      CollectionReference<Map<String, dynamic>> roomInstance = FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection);
      await roomInstance
          .doc(event.roomBookingModel.roomId)
          .get()
          .then((value) async {
        for (Map<String, dynamic> i in value
            .data()![FirebaseFirestoreConst.firebaseFireStoreBookingDeatails]) {
          if (i[FirebaseFirestoreConst.firebaseFireStoreBookingId] ==
              event.bookingId) {
            roomInstance.doc(event.roomBookingModel.roomId).update({
              FirebaseFirestoreConst.firebaseFireStoreBookingDeatails:
                  FieldValue.arrayRemove([i])
            });
          }
        }
      });

      var userInstance = FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
      await userInstance
          .doc(event.userId)
          .collection(FirebaseFirestoreConst
              .firebaseFireStoreCurrentBookingAndPayAtHotelRoomCollection)
          .doc(event.bookingId)
          .delete();
      emit(RoomBookingDeletedState());
    });
    // cancel room booking
    on<OnCancelRoomBooking>((event, emit) async {
      var a = await Alerts().dialgForDelete(
        roomBookingModel: event.roomBookingModel,
        context: event.context,
        text: event.text,
      );
      if (a) {
        emit(RoomBookingCancelSuccessState());
      }
    });
    // on navigate pay button
    on<OnNavigateByPayNoeButton>((event, emit) {
      if (startingDate != null) {
        Navigator.of(event.mainContext).push(MaterialPageRoute(
          builder: (_) {
            return PaymentScreen(
              mainContext: event.mainContext,
              price: event.price,
            );
          },
        ));
      } else {
        emit(RoomBookingErrorState(text: 'Please select a date'));
      }
    });
    // to press and check pay at hotel
    on<OnCkeckToPressBookNowAndPayAtHotel>((event, emit) {
      if (startingDate == null) {
        emit(RoomBookingErrorState(text: 'Please select a date'));
      } else {
        DateTime today = DateTime.now();
        if (startingDate!.month == today.month &&
            startingDate!.day == today.day) {
          emit(RoomBookingBookNowAndPayAtHotelSuccessState());
        } else {
          emit(RoomBookingErrorState(
              text: 'You can only use this option for todays booking'));
        }
      }
    });
  }
}
