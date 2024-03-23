import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_bloc.dart';
import 'package:share/user/aplication/search_bloc/search_bloc.dart';
import 'package:share/user/aplication/search_bloc/search_event.dart';
import 'package:share/user/aplication/search_bloc/search_state.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    log('main page loading again ------------------------------------');
    return ListView(children: [
      CommonWidget().customSearchBar(context),
      Column(
        children: [
          Column(
            children: [
              CommonWidget().categoryList(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget().sortButton(context),
                  CommonWidget().filtertButton(context)
                ],
              ),
            ],
          ),
          // ),
          BlocConsumer<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SortSuccessState) {
                BlocProvider.of<SearchBloc>(context)
                    .add(OnRoomDeatailsFilteringEvent());
              }
            },
            builder: (context, state) {
              if (state is RoomDeatailsLoadingSearchhState) {
                return CommonWidget().loadingWidget();
              } else if (state is InitialSearchState) {
                BlocProvider.of<SearchBloc>(context)
                    .add(OnRoomDeatailsFilteringEvent());
                return CommonWidget().loadingWidget();
              } else {
                return BlocProvider.of<SearchBloc>(context)
                        .listRoomModel
                        .isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/images/no data found.json'),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'No Room found',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.grey),
                          )
                        ],
                      )
                    : Column(
                        children: List.generate(
                            BlocProvider.of<SearchBloc>(context)
                                .listRoomModel
                                .length, (index) {
                          return BlocProvider(
                              create: (context) => RatingAndFeedbackBloc(),
                              child: CommonWidget().roomShowingContainer(
                                  context: context,
                                  roomModel:
                                      BlocProvider.of<SearchBloc>(context)
                                          .listRoomModel[index]));
                        }),
                      );
              }
            },
          ),
        ],
      )
    ]);
  }
}
