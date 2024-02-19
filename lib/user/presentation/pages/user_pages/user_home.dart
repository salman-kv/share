import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/search_bloc/search_bloc.dart';
import 'package:share/user/aplication/search_bloc/search_event.dart';
import 'package:share/user/aplication/search_bloc/search_state.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';

class UserHome extends StatelessWidget {
  UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    log('main page loading again ------------------------------------');
    return ListView(
      children: [
        CommonWidget().customSearchBar(context),
        Column(
          children: [
            CommonWidget().categoryList(context),
            Visibility(
              visible: context.watch<SearchBloc>().visibility,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget().sortButton(context),
                  CommonWidget().filtertButton(context)
                ],
              ),
            ),
            BlocConsumer<SearchBloc, SearchState>(
              listener: (context, state) {

              },
              builder: (context, state) {
                if (state is RoomDeatailsLoadingSearchhState) {
                  return const CircularProgressIndicator();
                } else if (state is InitialSearchState) {
                   BlocProvider.of<SearchBloc>(context)
                      .add(InitialRoomFetchingSearchEvent());
                  return const CircularProgressIndicator();
                } else {
                  return Column(
                    children: List.generate(
                        BlocProvider.of<SearchBloc>(context)
                            .listRoomModel
                            .length, (index) {
                      return CommonWidget().romShowingContainer(
                          context: context,
                          roomModel: BlocProvider.of<SearchBloc>(context)
                              .listRoomModel[index]);
                    }),
                  );
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
