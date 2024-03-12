import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_bloc.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_event.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_state.dart';
import 'package:share/user/domain/model/rating_and_feedback_model.dart';
import 'package:share/user/domain/model/room_booking_model.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class RatingAndFeedback extends StatelessWidget {
  final RoomBookingModel roomBookingModel;
  RatingAndFeedback({required this.roomBookingModel, super.key});

  var feedbackControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingAndFeedbackBloc, RatingAndFeedbackState>(
      listener: (context, state) {
        if (state is RatingUpdatedState) {
          SnackBars().successSnackBar('Rating updated', context);
        } else if (state is RatingAndFeedbackSubmitedState) {
          SnackBars().successSnackBar(
              'Rating and feedback submited successfully', context);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rating',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Select Rating',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          if (index <=
                              context
                                  .watch<RatingAndFeedbackBloc>()
                                  .selectedStars) {
                            return IconButton(
                                onPressed: () {
                                  BlocProvider.of<RatingAndFeedbackBloc>(
                                          context)
                                      .add(OnRatingSelectedEvent(index: index));
                                },
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ));
                          } else {
                            return IconButton(
                                onPressed: () {
                                  BlocProvider.of<RatingAndFeedbackBloc>(
                                          context)
                                      .add(OnRatingSelectedEvent(index: index));
                                },
                                icon: const Icon(
                                  Icons.star_border,
                                  color: Colors.amber,
                                ));
                          }
                        }),
                      ),
                    ],
                  ),
                  Text(
                    'Feedback',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: TextField(
                        controller: feedbackControlller,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.black),
                        maxLines: 100,
                        decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 235, 235, 235),
                            filled: true,
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: Styles().elevatedButtonDecration(),
                      child: ElevatedButton(
                        style: Styles().elevatedButtonStyle(),
                        onPressed: () {
                          if (feedbackControlller.text.isNotEmpty) {
                            BlocProvider.of<RatingAndFeedbackBloc>(context).add(
                                OnRatingAnfeedbackSubmit(
                                    ratingAndFeedbackModel:
                                        RatingAndFeedbackModel(
                                            roomid: roomBookingModel.roomId,
                                            userid: roomBookingModel.userId,
                                            rating: context
                                                    .read<
                                                        RatingAndFeedbackBloc>()
                                                    .selectedStars +
                                                1,
                                            feedback:
                                                feedbackControlller.text)));
                          } else {
                            SnackBars().errorSnackBar(
                                'Feedback is empty , please add some feedback',
                                context);
                          }
                        },
                        child: Text(
                          'Submit',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
