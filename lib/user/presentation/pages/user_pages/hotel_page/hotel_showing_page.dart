import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/hotel_bloc/hotel_bloc.dart';
import 'package:share/user/aplication/hotel_bloc/hotel_event.dart';
import 'package:share/user/aplication/hotel_bloc/hotel_state.dart';
import 'package:share/user/domain/enum/hotel_type.dart';
import 'package:share/user/presentation/const/const_color.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';

class HotelShowingPage extends StatelessWidget {
  const HotelShowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            BlocConsumer<HotelBloc, HotelState>(
              listener: (context, state) {
                // if(state is HotelSuccessState){
                //   BlocProvider.of<HotelBloc>(context).add(OnHotelRoomDeatialsAddingEvent());
                // }
              },
              builder: (context, state) {
                if (state is HotelInitialState) {
                  log('initial state');
                  BlocProvider.of<HotelBloc>(context)
                      .add(OnHotelDeatialsAddingEvent());
                  return Center(
                    child: CommonWidget().loadingWidget(),
                  );
                } else if (state is HotelLoadingState) {
                  log('loading state');
                  return Center(
                    child: CommonWidget().loadingWidget(),
                  );
                } else {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                // color:
                                //     ConstColor().mainColorblue.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20)),
                            child: CarouselSlider(
                                items: List.generate(
                                    context
                                        .watch<HotelBloc>()
                                        .mainPropertyModel!
                                        .image
                                        .length, (index) {
                                  return Image.network(context
                                      .watch<HotelBloc>()
                                      .mainPropertyModel!
                                      .image[index]);
                                }),
                                options: CarouselOptions()),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        context
                                            .watch<HotelBloc>()
                                            .mainPropertyModel!
                                            .propertyNmae,
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
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 25),
                              Text(
                                context
                                    .watch<HotelBloc>()
                                    .mainPropertyModel!
                                    .place,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            child: Text(
                                context
                                            .watch<HotelBloc>()
                                            .mainPropertyModel!
                                            .hotelType ==
                                        HotelType.hotel
                                    ? 'Type : Hotel'
                                    : 'Type : Dormitory',
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            child: Text(
                                'Rooms : ${context.watch<HotelBloc>().mainPropertyModel!.rooms.length}',
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          //  context.watch<HotelBloc>().listRoomModel.isEmpty? null: Column()
                          Column(
                            children: List.generate(
                                    context
                                        .watch<HotelBloc>()
                                        .listRoomModel
                                        .length, (index) {
                                    return CommonWidget()
                                        .roomShowingContainerInsideTheHotelPage(
                                            context: context,
                                            roomModel: context
                                                .watch<HotelBloc>()
                                                .listRoomModel[index]);
                                  }),
                          ),
                        ],
                      ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
