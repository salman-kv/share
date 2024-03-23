import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_bloc.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_event.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_state.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_state.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_bloc.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_event.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_state.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/enum/hotel_type.dart';
import 'package:share/user/domain/model/rating_and_feedback_model.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';
import 'package:share/user/presentation/widgets/rating_feedback_widget.dart';
import 'package:share/user/presentation/widgets/room_booking_widget.dart';

class RoomDeatailedShowingPage extends StatelessWidget {
  final String roomId;
  const RoomDeatailedShowingPage({required this.roomId, super.key});

  @override
  Widget build(BuildContext context) {
    log('single room keranind');
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SingleRoomBloc(),
          ),
          BlocProvider(
            create: (context) => RoomBookingBloc(),
          )
        ],
        child: BlocConsumer<RoomBookingBloc, RoomBookingState>(
          listener: (context, state) {
            if (state is RoomBookingErrorState) {
              SnackBars().errorSnackBar(state.text, context);
            }
          },
          builder: (context, state) {
            return BlocConsumer<SingleRoomBloc, SingleRoomState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SingleRoomInitialState) {
                  BlocProvider.of<SingleRoomBloc>(context)
                      .add(OnInitialRoomDeatailsAddingEvent(id: roomId));
                  return Center(child: CommonWidget().loadingWidget());
                } else if (state is SingleRoomLoadingState) {
                  return Center(child: CommonWidget().loadingWidget());
                } else {
                  return SafeArea(
                      child: Scaffold(
                    appBar: AppBar(),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListView(
                        children: [
                          CarouselSlider(
                            items: List.generate(
                                context
                                    .watch<SingleRoomBloc>()
                                    .roomModel!
                                    .images
                                    .length, (index) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(context
                                        .watch<SingleRoomBloc>()
                                        .roomModel!
                                        .images[index]),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            }),
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 8),
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 2),
                              viewportFraction: 1,
                              clipBehavior: Clip.antiAlias,
                              enlargeCenterPage: true,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      context
                                          .watch<SingleRoomBloc>()
                                          .roomModel!
                                          .hotelName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    context
                                            .watch<UserLoginBloc>()
                                            .favoriteRooms
                                            .contains(roomId)
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.favorite,
                                              size: 30,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<UserLoginBloc>(
                                                      context)
                                                  .add(OnTapFavoriteEvent(
                                                      roomId: roomId));
                                            },
                                          )
                                        : IconButton(
                                            icon: const Icon(
                                              Icons.favorite,
                                              size: 30,
                                              color: Color.fromARGB(
                                                  255, 202, 202, 202),
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<UserLoginBloc>(
                                                      context)
                                                  .add(OnTapFavoriteEvent(
                                                      roomId: roomId));
                                            },
                                          )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 20),
                              Text(
                                context
                                    .watch<SingleRoomBloc>()
                                    .roomModel!
                                    .place!,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                                context
                                    .watch<SingleRoomBloc>()
                                    .roomModel!
                                    .roomNumber,
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              context
                                          .watch<SingleRoomBloc>()
                                          .roomModel!
                                          .roomType ==
                                      HotelType.hotel
                                  ? 'Hotel'
                                  : 'Dormetiory',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          Text(
                            '₹ ${context.watch<SingleRoomBloc>().roomModel!.price}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Features',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    context
                                        .watch<SingleRoomBloc>()
                                        .roomModel!
                                        .features
                                        .length, (index) {
                                  return Text(context
                                      .watch<SingleRoomBloc>()
                                      .roomModel!
                                      .features[index]);
                                }),
                              )),
                          RoomBookingWidget().bookingContainer(
                              context: context,
                              roomModel:
                                  context.watch<SingleRoomBloc>().roomModel!),
                          RoomBookingWidget().totalpaymentContainer(
                              context: context,
                              price: context
                                  .watch<SingleRoomBloc>()
                                  .roomModel!
                                  .price),
                          BlocBuilder<RoomBookingBloc, RoomBookingState>(
                            builder: (context, state) {
                              if (state is RoomBookingLoadingState) {
                                return const SizedBox();
                              } else {
                                return Row(
                                  children: [
                                    RoomBookingWidget().payNowButton(
                                        context: context,
                                        price: context
                                                    .watch<RoomBookingBloc>()
                                                    .startingDate !=
                                                null
                                            ? context
                                                    .watch<RoomBookingBloc>()
                                                    .endingDate!
                                                    .difference(BlocProvider.of<
                                                                RoomBookingBloc>(
                                                            context)
                                                        .startingDate!)
                                                    .inDays *
                                                BlocProvider.of<SingleRoomBloc>(
                                                        context)
                                                    .roomModel!
                                                    .price
                                            : BlocProvider.of<SingleRoomBloc>(
                                                    context)
                                                .roomModel!
                                                .price),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    RoomBookingWidget().bookAndPayAtHotel(
                                        context: context,
                                        price: context
                                                    .watch<RoomBookingBloc>()
                                                    .startingDate !=
                                                null
                                            ? context
                                                    .watch<RoomBookingBloc>()
                                                    .endingDate!
                                                    .difference(BlocProvider.of<
                                                                RoomBookingBloc>(
                                                            context)
                                                        .startingDate!)
                                                    .inDays *
                                                BlocProvider.of<SingleRoomBloc>(
                                                        context)
                                                    .roomModel!
                                                    .price
                                            : BlocProvider.of<SingleRoomBloc>(
                                                    context)
                                                .roomModel!
                                                .price),
                                  ],
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Rating & Reviews',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(FirebaseFirestoreConst
                                    .firebaseFireStoreRoomCollection)
                                .doc(roomId)
                                .collection(FirebaseFirestoreConst
                                    .firebaseFireStoreRatingAndFeedback)
                                .snapshots(),
                            builder: (context, snapshot) {
                              BlocProvider.of<RatingAndFeedbackBloc>(context)
                                  .add(OnTotalRatingCalculation(
                                      snapshot: snapshot));
                              if (snapshot.hasData) {
                                if (snapshot.data!.docs.isNotEmpty) {
                                  return BlocBuilder<RatingAndFeedbackBloc,
                                      RatingAndFeedbackState>(
                                    builder: (context, state) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                BlocProvider.of<
                                                            RatingAndFeedbackBloc>(
                                                        context)
                                                    .totalRatingAvarageStars
                                                    .toStringAsFixed(2),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(fontSize: 35),
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: List.generate(5,
                                                        (index) {
                                                      if (index <
                                                          BlocProvider.of<
                                                                      RatingAndFeedbackBloc>(
                                                                  context)
                                                              .totalRatingAvarageStars) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 30,
                                                        );
                                                      } else {
                                                        return const Icon(
                                                          Icons.star_border,
                                                          color: Colors.amber,
                                                          size: 30,
                                                        );
                                                      }
                                                    }),
                                                  ),
                                                  Text(
                                                    '${BlocProvider.of<RatingAndFeedbackBloc>(context).totalEntries} Reviews',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: List.generate(
                                                snapshot.data!.docs.length,
                                                (index) {
                                              return RatingAndFeedbackWidget()
                                                  .ratingFeedbackContainer(
                                                      ratingAndFeedbackModel:
                                                          RatingAndFeedbackModel
                                                              .fromMap(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .data()));
                                            }),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Text(
                                    '(No reviews)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  );
                                }
                              } else {
                                return Text('no snapshort');
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
