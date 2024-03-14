import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_event.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';

class RatingAndFeedbackBloc
    extends Bloc<RatingAndFeedbackEvent, RatingAndFeedbackState> {
  int selectedStars = 0;
  double totalRatingAvarageStars = 0;
  int totalEntries = 0;
  RatingAndFeedbackBloc() : super(InitialRatingAndFeedbackState()) {
    on<OnRatingSelectedEvent>((event, emit) {
      log('${event.index}');
      selectedStars = event.index;
      emit(RatingUpdatedState());
    });
    on<OnRatingAnfeedbackSubmit>((event, emit) async {
      await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .doc(event.ratingAndFeedbackModel.roomid)
          .collection(FirebaseFirestoreConst.firebaseFireStoreRatingAndFeedback)
          .add(event.ratingAndFeedbackModel.toMap());
      selectedStars = 0;
      emit(RatingAndFeedbackSubmitedState());
    });
    on<OnTotalRatingCalculation>((event, emit) {
      if (event.snapshot.hasData) {
        if (event.snapshot.data!.docs.isNotEmpty) {
          int tempStarCount = 0;
          for (var i in event.snapshot.data!.docs) {
            tempStarCount = tempStarCount +
                int.parse(i
                    .data()[FirebaseFirestoreConst.firebaseFireStoreRating]
                    .toString());
          }
          totalRatingAvarageStars =
              (tempStarCount / event.snapshot.data!.docs.length);
          totalEntries = event.snapshot.data!.docs.length;
        }
      }
      emit(RatingCountUpdatedState());
    });
  }
}
