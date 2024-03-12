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