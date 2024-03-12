import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';

class RatingAndFeedbackModel {
  final String roomid;
  final String userid;
  final int rating;
  final String feedback;

  RatingAndFeedbackModel(
      {required this.roomid,
      required this.userid,
      required this.rating,
      required this.feedback});

  static RatingAndFeedbackModel fromMap(Map<String, dynamic> map) {
    return RatingAndFeedbackModel(
        roomid: map[FirebaseFirestoreConst.firebaseFireStoreRoomId],
        userid: map[FirebaseFirestoreConst.firebaseFireStoreUserId],
        rating: map[FirebaseFirestoreConst.firebaseFireStoreRating],
        feedback: map[FirebaseFirestoreConst.firebaseFireStoreFeedback]);
  }
  toMap(){
    return{
      FirebaseFirestoreConst.firebaseFireStoreRoomId: roomid,
      FirebaseFirestoreConst.firebaseFireStoreUserId:userid,
      FirebaseFirestoreConst.firebaseFireStoreRating:rating,
      FirebaseFirestoreConst.firebaseFireStoreFeedback:feedback
    };
  }
}
