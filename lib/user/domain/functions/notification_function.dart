import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/notification_model.dart';
import 'package:share/user/domain/model/room_booking_model.dart';

class NotificationFunction{
  notificationFunction({required RoomBookingModel roomBookingModel,required String notificationPurpose,required String notificationData})async{
    await FirebaseFirestore.instance
          .collection(
              FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
          .get()
          .then((value) async {
        for (var i in value.docs) {
          if (i.data().containsKey('hotel')) {
            if (i.data()['hotel'].contains(roomBookingModel.hotelId)) {
              // add to notification
              NotificationModel notificationModel = NotificationModel(
                opened: false,
                  notificationTime: DateTime.now(),
                  notificationPurpose: notificationPurpose,
                  notificationData: notificationData,
                  roomBookingModel: roomBookingModel);
              await FirebaseFirestore.instance
                  .collection(FirebaseFirestoreConst
                      .firebaseFireStoreSubAdminCollection)
                  .doc(i.id)
                  .collection(
                      FirebaseFirestoreConst.firebaseFireStoreNotification)
                  .add(notificationModel.toMap());
            }
          }
        }
      });
  }

}