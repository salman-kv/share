import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:share/user/aplication/filter_bloc/filter_bloc.dart';
import 'package:share/user/aplication/filter_bloc/filter_event.dart';
import 'package:share/user/aplication/filter_bloc/filter_state.dart';
import 'package:share/user/aplication/hotel_bloc/hotel_bloc.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_bloc.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_event.dart';
import 'package:share/user/aplication/rating_and_feedback/rating_and_feedback_state.dart';
import 'package:share/user/aplication/search_bloc/search_bloc.dart';
import 'package:share/user/aplication/search_bloc/search_event.dart';
import 'package:share/user/aplication/search_bloc/search_state.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/enum/hotel_type.dart';
import 'package:share/user/domain/functions/user_firestroe_funciton.dart';
import 'package:share/user/domain/model/main_property_model.dart';
import 'package:share/user/domain/model/room_model.dart';
import 'package:share/user/presentation/alerts/alert.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/const/const_color.dart';
import 'package:share/user/presentation/pages/history_page/history_page.dart';
import 'package:share/user/presentation/pages/privacy_policy/privacy_policy.dart';
import 'package:share/user/presentation/pages/profile/profile_page.dart';
import 'package:share/user/presentation/pages/terms_and_condition/terms_and_condition.dart';
import 'package:share/user/presentation/pages/user_pages/favorite_page/favorite_page.dart';
import 'package:share/user/presentation/pages/user_pages/hotel_page/hotel_showing_page.dart';
import 'package:share/user/presentation/pages/user_pages/rating_feedback/rating_and_feedback.dart';
import 'package:share/user/presentation/pages/user_pages/room_page/room_deatailed_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

TextEditingController searchController = TextEditingController();
final Uri _url = Uri.parse('https://www.instagram.com/_salman_kv_/');

class CommonWidget {
  customSearchBar(context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is OnChangeSearchState) {
          BlocProvider.of<SearchBloc>(context)
              .add(OnRoomDeatailsFilteringEvent());
        }
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: SearchBar(
            onTap: () {},
            controller: searchController,
            elevation: const MaterialStatePropertyAll<double>(1.5),
            backgroundColor: const MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 255, 255, 255)),
            leading: IconButton(
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    BlocProvider.of<SearchBloc>(context)
                        .add(OnChangeSearchEvent(text: searchController.text));
                    BlocProvider.of<SearchBloc>(context)
                        .add(OnTapSearchEvent());
                    BlocProvider.of<FilterBloc>(context)
                        .add(OnCancelSearchAndFilterRemoveEvent());
                  } else {
                    SnackBars()
                        .errorSnackBar('Pleas enter your place', context);
                  }
                },
                icon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.grey,
                )),
            onSubmitted: (value) {
              if (searchController.text.isNotEmpty) {
                BlocProvider.of<SearchBloc>(context)
                    .add(OnChangeSearchEvent(text: searchController.text));
                BlocProvider.of<SearchBloc>(context).add(OnTapSearchEvent());
                BlocProvider.of<FilterBloc>(context)
                    .add(OnCancelSearchAndFilterRemoveEvent());
              } else {
                SnackBars().errorSnackBar('Pleas enter your place', context);
              }
            },
            hintText: 'Search by place and hotel name . . .',
            hintStyle: MaterialStatePropertyAll<TextStyle>(Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Colors.grey)),
            textStyle: MaterialStatePropertyAll<TextStyle>(
              Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black),
            ),
            trailing: context.watch<SearchBloc>().visibility
                ? [
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<FilterBloc>(context).rangeValues =
                              const RangeValues(0, 5000);
                          BlocProvider.of<SearchBloc>(context)
                              .add(OnCancelSearchEvent());

                          searchController.text = '';
                        },
                        icon: const Icon(
                          Icons.cancel,
                          size: 30,
                          color: Colors.grey,
                        ))
                  ]
                : null,
            onChanged: (value) {},
            // onSubmitted: (value) {
            //   if (searchController.text.isNotEmpty) {
            //     BlocProvider.of<SearchBloc>(context).add(OnTapSearchEvent());
            //   } else {
            //     SnackBars().errorSnackBar('Pleas enter your place', context);
            //   }
            //   BlocProvider.of<SearchBloc>(context)
            //           .add(OnChangeSearchEvent(text: searchController.text));
            // },
          ),
        );
      },
    );
  }

  // categorylist for the main page hotel dormetry all

  categoryList(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is CatogoryChangedSearchState) {
          BlocProvider.of<SearchBloc>(context)
              .add(OnRoomDeatailsFilteringEvent());
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                BlocProvider.of<SearchBloc>(context).list.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<SearchBloc>(context)
                          .add(OnTapCatogoryChangeEvent(index: index));
                    },
                    child: Container(
                      height: 40,
                      constraints: const BoxConstraints(minWidth: 100),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: BlocProvider.of<SearchBloc>(context).list[index]
                                ['select']
                            ? MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Colors.white
                                : Colors.black
                            : ConstColor().mainColorblue.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Text(
                          BlocProvider.of<SearchBloc>(context).list[index]
                              ['name'],
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: BlocProvider.of<SearchBloc>(context)
                                        .list[index]['select']
                                    ? MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                        : const Color.fromARGB(
                                            255, 255, 255, 255)
                                    : MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? const Color.fromARGB(
                                            255, 255, 255, 255)
                                        : const Color.fromARGB(255, 0, 0, 0),
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  // sort button

  sortButton(BuildContext context) {
    return InkWell(
      onTap: () {
        sortBottomSheet(context);
      },
      child: Container(
        height: 40,
        constraints: const BoxConstraints(minWidth: 150),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          color: ConstColor().mainColorblue.withOpacity(0.3),
        ),
        child: Center(
            child: Row(
          children: [
            Text(
              'Sort',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(255, 0, 0, 0),
                  ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              FontAwesomeIcons.sort,
              size: 25,
            )
          ],
        )),
      ),
    );
  }

  // filter button

  filtertButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        BlocProvider.of<FilterBloc>(context).tempRangeValues =
            BlocProvider.of<FilterBloc>(context).rangeValues;
        BlocProvider.of<FilterBloc>(context).tempFeatures.clear();
        BlocProvider.of<FilterBloc>(context)
            .tempFeatures
            .addAll(BlocProvider.of<FilterBloc>(context).features);
        filterBottomSheet(context);
      },
      child: Container(
        height: 40,
        constraints: const BoxConstraints(minWidth: 150),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          color: ConstColor().mainColorblue.withOpacity(0.3),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Filter',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(255, 0, 0, 0),
                  ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.filter_alt,
              size: 25,
            )
          ],
        )),
      ),
    );
  }

// single hotel showing page

  roomShowingContainer(
      {required BuildContext context, required RoomModel roomModel}) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return RoomDeatailedShowingPage(
          roomId: roomModel.id!,
        );
      })),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ConstColor().mainColorblue.withOpacity(0.3),
            ),
            constraints: const BoxConstraints(minHeight: 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: shimmerChild(roomModel.images[0])),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              roomModel.hotelName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            context
                                    .watch<UserLoginBloc>()
                                    .favoriteRooms
                                    .contains(roomModel.id)
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<UserLoginBloc>(context)
                                          .add(OnTapFavoriteEvent(
                                              roomId: roomModel.id!));
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      size: 30,
                                      color: Color.fromARGB(255, 138, 138, 138),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<UserLoginBloc>(context)
                                          .add(OnTapFavoriteEvent(
                                              roomId: roomModel.id!));
                                    },
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    roomModel.roomNumber,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.place),
                    Text('${roomModel.place}',
                        style: Theme.of(context).textTheme.titleSmall!)
                  ],
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      '₹ ${roomModel.price}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 20),
                    )),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirebaseFirestoreConst
                            .firebaseFireStoreRoomCollection)
                        .doc(roomModel.id)
                        .collection(FirebaseFirestoreConst
                            .firebaseFireStoreRatingAndFeedback)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        BlocProvider.of<RatingAndFeedbackBloc>(context)
                            .add(OnTotalRatingCalculation(snapshot: snapshot));
                        return BlocBuilder<RatingAndFeedbackBloc,
                            RatingAndFeedbackState>(
                          builder: (context, state) {
                            return Row(
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
                                      '${BlocProvider.of<RatingAndFeedbackBloc>(context).totalRatingAvarageStars.toStringAsFixed(2)} ( ${BlocProvider.of<RatingAndFeedbackBloc>(context).totalEntries} )',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    roomModel.roomType == HotelType.hotel
                                        ? 'Hotel'
                                        : 'Dormitory',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        return const Text('no review');
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // shimmer image child
  shimmerChild(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        (image),
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 230, 230, 230),
            highlightColor: const Color.fromARGB(255, 200, 200, 200),
            child: const ColoredBox(color: Colors.grey),
          );
        },
      ),
    );
  }

  // sort bottomsheet

  sortBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  right: 20,
                  left: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<SearchBloc>(context).add(OnSortEvent(
                            text: FirebaseFirestoreConst
                                .firebasefirestoreLowToHigh));
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(FontAwesomeIcons.circleUp),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Price - Low to High',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ),
                              ],
                            ),
                            context.watch<SearchBloc>().sort ==
                                    FirebaseFirestoreConst
                                        .firebasefirestoreLowToHigh
                                ? roundedContainerForIndication(
                                    context, ConstColor().mainColorblue)
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<SearchBloc>(context).add(OnSortEvent(
                            text: FirebaseFirestoreConst
                                .firebasefirestoreHighToLow));
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(FontAwesomeIcons.circleDown),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Price - High to Low',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ),
                              ],
                            ),
                            context.watch<SearchBloc>().sort ==
                                    FirebaseFirestoreConst
                                        .firebasefirestoreHighToLow
                                ? roundedContainerForIndication(
                                    context, ConstColor().mainColorblue)
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01)
                  ],
                ),
              ),
            ));
  }

  // hotel Showing bottom sheet

  hotelBottomSheet(
      {required BuildContext context,
      required MainPropertyModel mainPropertyModel}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
              child: hotelShowingContainer(
                  context: context, mainPropertyModel: mainPropertyModel)),
        );
      },
    );
  }

  // sinle hotel showing page

  hotelShowingContainer(
      {required BuildContext context,
      required MainPropertyModel mainPropertyModel}) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return BlocProvider(
          create: (context) => HotelBloc(hotelId: mainPropertyModel.id!),
          child: const HotelShowingPage(),
        );
      })),
      child: Column(
        children: [
          bottomSheetTopContainer(context: context),
          Stack(
            children: [
              Container(
                // margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ConstColor().mainColorblue.withOpacity(0.3),
                ),
                constraints: const BoxConstraints(minHeight: 250),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(mainPropertyModel.image[0]),
                              fit: BoxFit.cover)),
                      child: CommonWidget()
                          .shimmerChild(mainPropertyModel.image[0]),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  mainPropertyModel.propertyNmae,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
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
                          mainPropertyModel.place,
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: Text(
                            mainPropertyModel.hotelType == HotelType.hotel
                                ? 'Type : Hotel'
                                : 'Type : Dormitory',
                            style: Theme.of(context).textTheme.titleMedium)),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: Text('Rooms : ${mainPropertyModel.rooms.length}',
                            style: Theme.of(context).textTheme.titleMedium)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          )
        ],
      ),
    );
  }

  // single room Showing container inside the hotel page
  roomShowingContainerInsideTheHotelPage(
      {required BuildContext context, required RoomModel roomModel}) {
    log('ethunund');
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return RoomDeatailedShowingPage(roomId: roomModel.id!);
          },
        ));
      },
      child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.1),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: ConstColor().mainColorblue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                          roomModel.images[0],
                        ),
                        fit: BoxFit.cover)),
                child: CommonWidget().shimmerChild(roomModel.images[0]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomModel.roomNumber,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '₹ ${roomModel.price}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

// bottom sheet top container

  bottomSheetTopContainer({required BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: MediaQuery.of(context).size.height * 0.005,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(100)),
    );
  }

  // round poit in diffrent color

  roundedContainerForIndication(BuildContext context, Color color) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.03,
      width: MediaQuery.of(context).size.width * 0.03,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(100)),
    );
  }

  // filter bottomsheet

  filterBottomSheet(BuildContext context) {
    final Set<String> commenFeatures = {
      'AC',
      'Wifi',
      'TV',
      'Attached Bathroom',
      'Commen Bathroom',
      'Swimming pool',
      'Parking',
      'Balcony'
    };
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        context: context,
        isScrollControlled: true,
        builder: (context) => BlocConsumer<FilterBloc, FilterState>(
              listener: (context, state) {
                if (state is SubmitedFilterStare) {
                  log('ivde vare varnd');
                  BlocProvider.of<SearchBloc>(context).add(
                      FilterDeatailsAddingEvent(
                          rangeValues:
                              BlocProvider.of<FilterBloc>(context).rangeValues,
                          features:
                              BlocProvider.of<FilterBloc>(context).features));

                  BlocProvider.of<SearchBloc>(context)
                      .add(OnRoomDeatailsFilteringEvent());
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                RangeSlider(
                                  labels: const RangeLabels('start', 'end'),
                                  min: 0,
                                  max: 5000,
                                  values: context
                                          .watch<FilterBloc>()
                                          .tempRangeValues ??
                                      const RangeValues(1, 1000),
                                  onChanged: (values) {
                                    BlocProvider.of<FilterBloc>(context).add(
                                        OnChangeFilterPriceEvent(
                                            rangeValues: values));
                                  },
                                ),
                                Row(
                                  children: [
                                    Text(
                                        '${context.watch<FilterBloc>().tempRangeValues}')
                                  ],
                                )
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            'Features',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Wrap(
                          children:
                              List.generate(commenFeatures.length, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                width: 150,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      // value: true,
                                      value: BlocProvider.of<FilterBloc>(
                                              context)
                                          .tempFeatures
                                          .contains(
                                              commenFeatures.elementAt(index)),
                                      onChanged: (value) {
                                        BlocProvider.of<FilterBloc>(context)
                                            .add(FeatureAddingInFilterEvent(
                                                val: commenFeatures
                                                    .elementAt(index)));
                                      },
                                    ),
                                    Expanded(
                                        child: Text(
                                      commenFeatures.elementAt(index),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ))
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<FilterBloc>(context).add(
                                      OnSubmitFilterEvent(
                                          rangeValues: context
                                              .read<FilterBloc>()
                                              .tempRangeValues!,
                                          features: context
                                              .read<FilterBloc>()
                                              .tempFeatures),
                                    );
                                  },
                                  child: Text('Filter'))),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01)
                      ],
                    ),
                  ),
                );
              },
            ));
  }

  // drawer function
  drawerReturnFunction(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(150, 0, 0, 0),
      child: BlocBuilder<UserLoginBloc, UserLoginState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.width * 0.45,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(150),
                    ),
                  ),
                  child:
                      BlocProvider.of<UserLoginBloc>(context).userModel == null
                          ? null
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: CommonWidget().profileNetworkImage(
                                  context: context,
                                  image: BlocProvider.of<UserLoginBloc>(context)
                                      .userModel!
                                      .imagePath),
                            )),
              Text(
                context.watch<UserLoginBloc>().userModel != null
                    ? BlocProvider.of<UserLoginBloc>(context).userModel!.name
                    : '',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const ProfilePage();
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person_2_rounded,
                              size: 30,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              'Profile',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const FavoritePage();
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              'Favorite',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const HistoryPage();
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.history,
                              size: 30,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              'History',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launchUrl(_url);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person_2_outlined,
                              size: 30,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              'About us',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const PrivacyPolicyScreen();
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.security_rounded,
                              size: 30,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              'Privacy policy',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const TermsAndConditions();
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.privacy_tip_rounded,
                              size: 30,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              'Terms & Condition',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Alerts().dialgForDelete(
                            context: context,
                            function: UserFireStroreFunction().userLogOut,
                            text: 'Do you like to logout');
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? Colors.white
                              : Colors.black,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout_outlined,
                              size: 30,
                              color: Color.fromARGB(255, 214, 6, 6),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              'Log Out',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  // loaing widget
  loadingWidget() {
    return SizedBox(
      height: 150,
      width: 150,
      child: Lottie.asset('assets/images/loading.json'),
    );
  }

  // no data widget
  noDataWidget({required String text, required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/images/no data found.json'),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.grey),
        )
      ],
    );
  }

  // profile network image
  profileNetworkImage({required BuildContext context, required String image}) {
    return Image.network(
      image,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Lottie.asset('assets/images/profile_loading.json');
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/profile.png');
      },
    );
  }
}
