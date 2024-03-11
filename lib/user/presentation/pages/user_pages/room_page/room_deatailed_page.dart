import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_state.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_bloc.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_event.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_state.dart';
import 'package:share/user/domain/enum/hotel_type.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';
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
             if(state is RoomBookingErrorState){
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
                              autoPlayInterval: const Duration(seconds: 3),
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
                                    IconButton(
                                      icon: const Icon(
                                        Icons.favorite,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {},
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 25,
                                    color: Color.fromARGB(255, 230, 207, 5),
                                  ),
                                  Text(
                                    // propertyModel.place,
                                    '4.2 (250)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ],
                              ),
                              Text('view on Map')
                            ],
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
                          Row(
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
                                                      RoomBookingBloc>(context)
                                                  .startingDate!)
                                              .inDays *
                                          BlocProvider.of<SingleRoomBloc>(
                                                  context)
                                              .roomModel!
                                              .price
                                      : BlocProvider.of<SingleRoomBloc>(context)
                                          .roomModel!
                                          .price),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
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
                                                      RoomBookingBloc>(context)
                                                  .startingDate!)
                                              .inDays *
                                          BlocProvider.of<SingleRoomBloc>(
                                                  context)
                                              .roomModel!
                                              .price
                                      : BlocProvider.of<SingleRoomBloc>(context)
                                          .roomModel!
                                          .price),
                            ],
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
