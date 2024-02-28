import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';

class RoomBookingModel {
  final String hotelId;
  final String roomId;
  final String userId;
  final String roomNumber;
  final bool pending;
  final String image;
  final DateTime bookingTime;
  final int price;
  final Map<String, DateTime> bookedDate;

  RoomBookingModel(
      {required this.hotelId,
      required this.roomId,
      required this.userId,
      required this.roomNumber,
      required this.price,
      required this.bookedDate,
      required this.bookingTime,
      required this.image,
      required this.pending});

  Map<String, dynamic> toMap() {
    return {
      FirebaseFirestoreConst.firebaseFireStoreHotelId: hotelId,
      FirebaseFirestoreConst.firebaseFireStoreRoomId: roomId,
      FirebaseFirestoreConst.firebaseFireStoreUserId: userId,
      FirebaseFirestoreConst.firebaseFireStoreRoomNumber: roomNumber,
      FirebaseFirestoreConst.firebaseFireStoreRoomPrice: price,
      FirebaseFirestoreConst.firebaseFireStoreBookedDates: bookedDate,
      FirebaseFirestoreConst.firebaseFireStoreBookingTime: bookingTime,
      FirebaseFirestoreConst.firebaseFireStoreBookingPending: pending,
      FirebaseFirestoreConst.firebaseFireStoreRoomImages:image
    };
  }

  static RoomBookingModel fromMap(Map<String, dynamic> map) {
    return RoomBookingModel(
        hotelId: map[FirebaseFirestoreConst.firebaseFireStoreHotelId],
        roomId: map[FirebaseFirestoreConst.firebaseFireStoreRoomId],
        userId: map[FirebaseFirestoreConst.firebaseFireStoreUserId],
        roomNumber: map[FirebaseFirestoreConst.firebaseFireStoreRoomNumber],
        price: map[FirebaseFirestoreConst.firebaseFireStoreRoomPrice],
        bookedDate: {
          'start':DateTime.fromMillisecondsSinceEpoch(map[FirebaseFirestoreConst.firebaseFireStoreBookedDates]
                      ['start']
                  .seconds *
              1000) ,
          'end':DateTime.fromMillisecondsSinceEpoch(map[FirebaseFirestoreConst.firebaseFireStoreBookedDates]
                      ['end']
                  .seconds *
              1000) ,
        },
        bookingTime: DateTime.fromMillisecondsSinceEpoch(map[FirebaseFirestoreConst.firebaseFireStoreBookingTime].seconds * 1000),
        pending: map[FirebaseFirestoreConst.firebaseFireStoreBookingPending],
        image: map[FirebaseFirestoreConst.firebaseFireStoreRoomImages]
        
        );
  }
}
