import 'dart:developer';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_bloc.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_event.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_state.dart';
import 'package:share/user/domain/enum/hotel_type.dart';
import 'package:share/user/presentation/const/const_color.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';

class RoomDeatailedShowingPage extends StatelessWidget {
  final String roomId;
  const RoomDeatailedShowingPage({required this.roomId, super.key});

  @override
  Widget build(BuildContext context) {
    log('single room keranind');
    return Scaffold(
      body: BlocProvider(
        create: (context) => SingleRoomBloc(),
        child: BlocConsumer<SingleRoomBloc, SingleRoomState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SingleRoomInitialState) {
              BlocProvider.of<SingleRoomBloc>(context)
                  .add(OnInitialRoomDeatailsAddingEvent(id: roomId));
              return const Center(child: CircularProgressIndicator());
            } else if (state is SingleRoomLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SafeArea(
                  child: Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView(
                    children: [
                      Container(
                        // margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: ConstColor().mainColorblue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: CarouselSlider(
                            items: List.generate(
                                context
                                    .watch<SingleRoomBloc>()
                                    .roomModel!
                                    .images
                                    .length, (index) {
                              return Image.network(context
                                  .watch<SingleRoomBloc>()
                                  .roomModel!
                                  .images[index]);
                            }),
                            options: CarouselOptions()),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context
                                      .watch<SingleRoomBloc>()
                                      .roomModel!
                                      .hotelName,
                                  style: Theme.of(context).textTheme.titleLarge,
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
                            context.watch<SingleRoomBloc>().roomModel!.place!,
                            style: Theme.of(context).textTheme.displayMedium,
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
                          context.watch<SingleRoomBloc>().roomModel!.roomType ==
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
                                style: Theme.of(context).textTheme.displaySmall,
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
                      CommonWidget().bookingContainer(
                          context: context,
                          roomModel:
                              context.watch<SingleRoomBloc>().roomModel!),
                      CommonWidget().totalpaymentContainer(context: context),
                      Row(
                        children: [
                          CommonWidget().payNowButton(context: context),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          CommonWidget().bookAndPayAtHotel(context: context),
                        ],
                      )
                    ],
                  ),
                ),
              ));
            }
          },
        ),
      ),
    );
  }
}
