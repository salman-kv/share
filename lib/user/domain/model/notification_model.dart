import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/room_booking_model.dart';

class NotificationModel {
  final String notificationPurpose;
  final String notificationData;
  final RoomBookingModel roomBookingModel;
  final DateTime notificationTime;
  final bool opened;

  NotificationModel(
      {required this.notificationPurpose,
      required this.opened,
      required this.notificationData,
      required this.roomBookingModel,
      required this.notificationTime});

  static NotificationModel fromMap(Map<String, dynamic> map) {
    return NotificationModel(
        opened: map[FirebaseFirestoreConst.firebaseFireStoreNotificationOpened],
        notificationTime: DateTime.fromMillisecondsSinceEpoch(
            map[FirebaseFirestoreConst.firebaseFireStoreNotificationTime]
                    .seconds *
                1000),
        notificationPurpose:
            map[FirebaseFirestoreConst.firebaseFireStoreNotificationPurpose],
        notificationData:
            map[FirebaseFirestoreConst.firebaseFireStoreNotificationData],
        roomBookingModel: RoomBookingModel.fromMap(map[FirebaseFirestoreConst
            .firebaseFireStoreNotificationRoomBookingModel]));
  }

  toMap() {
    return {
      FirebaseFirestoreConst.firebaseFireStoreNotificationOpened: opened,
      FirebaseFirestoreConst.firebaseFireStoreNotificationTime:
          notificationTime,
      FirebaseFirestoreConst.firebaseFireStoreNotificationPurpose:
          notificationPurpose,
      FirebaseFirestoreConst.firebaseFireStoreNotificationData:
          notificationData,
      FirebaseFirestoreConst.firebaseFireStoreNotificationRoomBookingModel:
          roomBookingModel.toMap()
    };
  }
}
