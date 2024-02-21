

import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/enum/hotel_type.dart';

class MainPropertyModel {
  final String? id;
  final String propertyNmae;
  final String place;
  final HotelType hotelType;
  final LatLng latLng;
  final List<dynamic> image;
  final List<dynamic> rooms;

  MainPropertyModel(
      {required this.propertyNmae,
      required this.place,
      required this.hotelType,
      required this.latLng,
      required this.image,
      required this.rooms,
      this.id
      });

  Map<String, dynamic> toMap() {
    return {
      FirebaseFirestoreConst.firebaseFireStoreHotelName: propertyNmae,
      FirebaseFirestoreConst.firebaseFireStoreHotelPlace: place,
      FirebaseFirestoreConst.firebaseFireStoreHotelType: '$hotelType',
      FirebaseFirestoreConst.firebaseFireStoreHotelLatLng: {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude
      },
      FirebaseFirestoreConst.firebaseFireStoreHotelImages: image
    };
  }

  static MainPropertyModel fromMap(Map<String, dynamic> map,String id) {
    HotelType hotelType;
    if (map[FirebaseFirestoreConst.firebaseFireStoreHotelType] ==
        'HotelType.hotel') {
      hotelType = HotelType.hotel;
    } else {
      hotelType = HotelType.dormitory;
    }
    return MainPropertyModel(
        propertyNmae: map[FirebaseFirestoreConst.firebaseFireStoreHotelName],
        place: map[FirebaseFirestoreConst.firebaseFireStoreHotelPlace],
        hotelType: hotelType,
        latLng: LatLng(map['latlng']['latitude'], map['latlng']['longitude']),
        image: map[FirebaseFirestoreConst.firebaseFireStoreHotelImages],
        rooms: map[FirebaseFirestoreConst.firebaseFireStoreRooms]??[],
        id: id
        );
  }
}
