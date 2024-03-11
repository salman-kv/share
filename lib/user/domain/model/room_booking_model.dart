import 'dart:developer';

import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/checkin_checkout_model.dart';
import 'package:share/user/domain/model/payment_model.dart';

class RoomBookingModel {
  final String hotelId;
  final String roomId;
  final String userId;
  final String roomNumber;
  final String image;
  final DateTime bookingTime;
  final int price;
  final Map<String, DateTime> bookedDate;
  final PaymentModel? paymentModel;
   String? bookingId;
  CheckInCheckOutModel? checkInCheckOutModel;

  RoomBookingModel(
      {required this.hotelId,
      required this.roomId,
      required this.userId,
      required this.roomNumber,
      required this.price,
      required this.bookedDate,
      required this.bookingTime,
      required this.image,
      required this.paymentModel,
      required this.bookingId,
      required this.checkInCheckOutModel});

  Map<String, dynamic> toMap() {
    return {
      FirebaseFirestoreConst.firebaseFireStoreHotelId: hotelId,
      FirebaseFirestoreConst.firebaseFireStoreRoomId: roomId,
      FirebaseFirestoreConst.firebaseFireStoreUserId: userId,
      FirebaseFirestoreConst.firebaseFireStoreRoomNumber: roomNumber,
      FirebaseFirestoreConst.firebaseFireStoreRoomPrice: price,
      FirebaseFirestoreConst.firebaseFireStoreBookedDates: bookedDate,
      FirebaseFirestoreConst.firebaseFireStoreBookingTime: bookingTime,
      FirebaseFirestoreConst.firebaseFireStoreRoomImages: image,
      FirebaseFirestoreConst.firebaseFireStoreBookingId: bookingId,
      FirebaseFirestoreConst.firebaseFireStoreCheckInORcheckOutDeatails:
         checkInCheckOutModel!=null ?  checkInCheckOutModel!.toMap() : null,
      FirebaseFirestoreConst.firebaseFireStorePaymentModel:
          paymentModel != null ? paymentModel!.toMap() : null
    };
  }

  static RoomBookingModel fromMap(Map<String, dynamic> map) {
    log('roombookingmodel from map');
    return RoomBookingModel(
        hotelId: map[FirebaseFirestoreConst.firebaseFireStoreHotelId],
        roomId: map[FirebaseFirestoreConst.firebaseFireStoreRoomId],
        userId: map[FirebaseFirestoreConst.firebaseFireStoreUserId],
        roomNumber: map[FirebaseFirestoreConst.firebaseFireStoreRoomNumber],
        price: map[FirebaseFirestoreConst.firebaseFireStoreRoomPrice],
        bookedDate: {
          'start': DateTime.fromMillisecondsSinceEpoch(
              map[FirebaseFirestoreConst.firebaseFireStoreBookedDates]['start']
                      .seconds *
                  1000),
          'end': DateTime.fromMillisecondsSinceEpoch(
              map[FirebaseFirestoreConst.firebaseFireStoreBookedDates]['end']
                      .seconds *
                  1000),
        },
        bookingTime: DateTime.fromMillisecondsSinceEpoch(
            map[FirebaseFirestoreConst.firebaseFireStoreBookingTime].seconds *
                1000),
        image: map[FirebaseFirestoreConst.firebaseFireStoreRoomImages],
        bookingId: map[FirebaseFirestoreConst.firebaseFireStoreBookingId],
        checkInCheckOutModel: map[FirebaseFirestoreConst
                    .firebaseFireStoreCheckInORcheckOutDeatails] !=
                null
            ? CheckInCheckOutModel.fromMap(map[FirebaseFirestoreConst
                .firebaseFireStoreCheckInORcheckOutDeatails])
            : null,
        paymentModel:
            map[FirebaseFirestoreConst.firebaseFireStorePaymentModel] != null
                ? PaymentModel.fromMap(
                    map[FirebaseFirestoreConst.firebaseFireStorePaymentModel])
                : null);
  }
}
