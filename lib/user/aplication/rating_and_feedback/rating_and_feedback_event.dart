import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:share/user/domain/model/rating_and_feedback_model.dart';

abstract class RatingAndFeedbackEvent{}
class OnRatingSelectedEvent extends RatingAndFeedbackEvent{
  final int index;

  OnRatingSelectedEvent({required this.index});
}
class OnRatingAnfeedbackSubmit extends RatingAndFeedbackEvent{
  final RatingAndFeedbackModel ratingAndFeedbackModel;

  OnRatingAnfeedbackSubmit({required this.ratingAndFeedbackModel});
}
class OnTotalRatingCalculation extends RatingAndFeedbackEvent{
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  OnTotalRatingCalculation({required this.snapshot});
}