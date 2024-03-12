import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_event.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';

class RatingAndFeedbackBloc
    extends Bloc<RatingAndFeedbackEvent, RatingAndFeedbackState> {
  int selectedStars = 0;
  RatingAndFeedbackBloc() : super(InitialRatingAndFeedbackState()) {
    on<OnRatingSelectedEvent>((event, emit) {
      selectedStars = event.index;
      emit(RatingUpdatedState());
    });
    on<OnRatingAnfeedbackSubmit>((event, emit) async {
      log('00000000000000000000');
      log('${event.ratingAndFeedbackModel.toMap()}');
      await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .doc(event.ratingAndFeedbackModel.roomid)
          .collection(
              FirebaseFirestoreConst.firebaseFireStoreRatingAndFeedback).add(event.ratingAndFeedbackModel.toMap());
              selectedStars = 0;
      emit(RatingAndFeedbackSubmitedState());
    });
  }
}
