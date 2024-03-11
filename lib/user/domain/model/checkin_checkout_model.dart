import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';

class CheckInCheckOutModel {
   DateTime? checkOutTime;
   DateTime? checkInTime;
   String request;

  CheckInCheckOutModel(
      {required this.checkOutTime,
      required this.checkInTime,
      required this.request});

  Map<String, dynamic> toMap() {
    return {
      FirebaseFirestoreConst.firebaseFireStoreCheckInTime: checkInTime,
      FirebaseFirestoreConst.firebaseFireStoreCheckOutTime: checkOutTime,
      FirebaseFirestoreConst.firebaseFireStoreCheckInORcheckOutRequest: request,
    };
  }

  static CheckInCheckOutModel fromMap(Map<String, dynamic> map) {
    return CheckInCheckOutModel(
      checkOutTime:map[FirebaseFirestoreConst.firebaseFireStoreCheckOutTime]!=null ? DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFirestoreConst.firebaseFireStoreCheckOutTime].seconds *
              1000) : null,
      checkInTime: map[FirebaseFirestoreConst.firebaseFireStoreCheckInTime]!=null ? DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFirestoreConst.firebaseFireStoreCheckInTime].seconds *
              1000) : null,
      request:
          map[FirebaseFirestoreConst.firebaseFireStoreCheckInORcheckOutRequest],
    );
  }
}
