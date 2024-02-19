
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/enum/hotel_type.dart';

class RoomModel {
  final String hotelId;
  final String hotelName;
  final String roomNumber;
  final int price;
  final int numberOfBed;
  final List<dynamic> features;
  final List<dynamic> images;
  final bool? availability;
  final HotelType? roomType;
  final LatLng? latlng;
  final String? place;

  RoomModel(
      {required this.availability,
      required this.hotelId,
      required this.hotelName,
      required this.roomNumber,
      required this.price,
      required this.numberOfBed,
      required this.features,
      required this.images,
      required this.roomType,
      required this.latlng,
      required this.place
      });

  static Map<String, dynamic> toMap(RoomModel roomModel) {
    return {
      FirebaseFirestoreConst.firebaseFireStoreHotelId: roomModel.hotelId,
      FirebaseFirestoreConst.firebaseFireStoreHotelName: roomModel.hotelName,
      FirebaseFirestoreConst.firebaseFireStoreRoomNumber: roomModel.roomNumber,
      FirebaseFirestoreConst.firebaseFireStoreRoomPrice: roomModel.price,
      FirebaseFirestoreConst.firebaseFireStoreNumberOfBed:
          roomModel.numberOfBed,
      FirebaseFirestoreConst.firebaseFireStoreRoomFeatures: roomModel.features,
      FirebaseFirestoreConst.firebaseFireStoreRoomImages: roomModel.images,
      FirebaseFirestoreConst.firebaseFireStoreRoomAvailability:
          roomModel.availability,
          FirebaseFirestoreConst.firebaseFireStoreHotelType:roomModel.roomType.toString(),
     FirebaseFirestoreConst.firebaseFireStoreHotelLatLng: {
        'latitude': roomModel.latlng!.latitude,
        'longitude': roomModel.latlng!.longitude
      },
      FirebaseFirestoreConst.firebaseFireStoreHotelPlace:roomModel.place
    };
  }

  static RoomModel fromMap(Map<String, dynamic> map) {
    HotelType hotelType;
    if (map[FirebaseFirestoreConst.firebaseFireStoreHotelType] ==
        'HotelType.hotel') {
      hotelType = HotelType.hotel;
    } else {
      hotelType = HotelType.dormitory;
    }
    return RoomModel(
        availability:
            map[FirebaseFirestoreConst.firebaseFireStoreRoomAvailability],
        hotelId: map[FirebaseFirestoreConst.firebaseFireStoreHotelId],
        hotelName: map[FirebaseFirestoreConst.firebaseFireStoreHotelName],
        roomNumber: map[FirebaseFirestoreConst.firebaseFireStoreRoomNumber],
        price: map[FirebaseFirestoreConst.firebaseFireStoreRoomPrice],
        numberOfBed: map[FirebaseFirestoreConst.firebaseFireStoreNumberOfBed],
        features: map[FirebaseFirestoreConst.firebaseFireStoreRoomFeatures],
        images: map[FirebaseFirestoreConst.firebaseFireStoreRoomImages],
        roomType: hotelType,
        latlng: LatLng(map['latlng']['latitude'], map['latlng']['longitude']),
        place: map[FirebaseFirestoreConst.firebaseFireStoreHotelPlace]
        );
  }
}


//  FirebaseFirestoreConst.firebaseFireStoreHotelId:roomModel.hotelId,
//       FirebaseFirestoreConst.firebaseFireStoreHotelName: roomModel.hotelName,
//       FirebaseFirestoreConst.firebaseFireStoreRoomNumber: roomModel.roomNumber,
//       FirebaseFirestoreConst.firebaseFireStoreRoomPrice: roomModel.price,
//       FirebaseFirestoreConst.firebaseFireStoreNumberOfBed: roomModel.numberOfBed,
//       FirebaseFirestoreConst.firebaseFireStoreRoomFeatures: roomModel.features,
//       FirebaseFirestoreConst.firebaseFireStoreRoomImages: roomModel.images,
//       FirebaseFirestoreConst.firebaseFireStoreRoomAvailability: roomModel.availability