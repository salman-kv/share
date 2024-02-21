import 'dart:developer';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:share/user/aplication/filter_bloc/filter_bloc.dart';
import 'package:share/user/aplication/filter_bloc/filter_event.dart';
import 'package:share/user/aplication/filter_bloc/filter_state.dart';
import 'package:share/user/aplication/search_bloc/search_bloc.dart';
import 'package:share/user/aplication/search_bloc/search_event.dart';
import 'package:share/user/aplication/search_bloc/search_state.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/user_function.dart';
import 'package:share/user/domain/model/main_property_model.dart';
import 'package:share/user/domain/model/room_model.dart';
import 'package:share/user/presentation/alerts/alert.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/const/const_color.dart';
import 'package:share/user/presentation/pages/userLogin/user_login_page.dart';
import 'package:share/user/presentation/pages/user_pages/room_page/room_deatailed_page.dart';

TextEditingController searchController = TextEditingController();

class CommonWidget {
  customSearchBar(context) {
    log('again search');
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is OnChangeSearchState) {
          BlocProvider.of<SearchBloc>(context)
              .add(OnRoomDeatailsFilteringEvent());
        }
      },
      builder: (context, state) {
        log('keranindeeeeeee +++++++++++++++++++++++++++++++++');
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
            hintText: 'Search By place . . .',
            hintStyle: MaterialStatePropertyAll<TextStyle>(Theme.of(context)
                .textTheme
                .displayMedium!
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
                            ? Colors.black
                            : ConstColor().mainColorblue.withOpacity(0.3),
                      ),
                      child: Center(
                          child: Text(
                        BlocProvider.of<SearchBloc>(context).list[index]
                            ['name'],
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: BlocProvider.of<SearchBloc>(context)
                                    .list[index]['select']
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : Colors.black),
                      )),
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
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.black),
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
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.black),
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

  romShowingContainer(
      {required BuildContext context, required RoomModel roomModel}) {
    // List<dynamic> tempImages = [];
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(roomModel.images[0]),
                          fit: BoxFit.fill)),
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
                      // propertyModel.place,
                      roomModel.place!,
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(roomModel.roomNumber,
                        style: Theme.of(context).textTheme.titleMedium)),
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
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        roomModel.roomType.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
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

  hotelBottomSheet({required BuildContext context,required MainPropertyModel mainPropertyModel}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(padding: EdgeInsets.only(
                  top: 20,
                  right: 20,
                  left: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
               child: SingleChildScrollView(
                child: hotelShowingContainer(context: context, mainPropertyModel: mainPropertyModel)
               ),   
                  );
      },
    );
  }

  // sinle hotel showing page

  hotelShowingContainer(
      {required BuildContext context, required MainPropertyModel mainPropertyModel}) {
    return GestureDetector(
      // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        // return RoomDeatailedShowingPage(
          // roomId: roomModel.id!,
        // );
      // })),
      child: Stack(
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(mainPropertyModel.image[0]),
                          fit: BoxFit.fill)),
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
                              'roomModel.hotelName',
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 25),
                    Text(
                      // propertyModel.place,
                      'roomModel.place!',
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text('roomModel.roomNumber',
                        style: Theme.of(context).textTheme.titleMedium)),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      '₹ {roomModel.price}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 20),
                    )),
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
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                       ' roomModel.roomType.toString()',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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

  // booking container

  bookingContainer(
      {required BuildContext context, required RoomModel roomModel}) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .02,
          bottom: MediaQuery.of(context).size.height * .02),
      constraints: const BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
          color: UserFunction().backgroundColorAlmostSame(context),
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: UserFunction().opositColor(context), width: 2)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Dates',
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    dateSelectingBottomSheet(context: context);
                  },
                  child: const Text(
                    'Selected date',
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.bed,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Selected Room',
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1),
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: UserFunction().opositColor(context),
                    ),
                    child: Center(
                      child: Text(
                        roomModel.roomNumber,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // total payment container
  totalpaymentContainer({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.06),
        decoration: BoxDecoration(
            color: ConstColor().mainColorblue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total Amount',
                style: Theme.of(context).textTheme.titleMedium),
            Text('₹ 1500', style: Theme.of(context).textTheme.titleLarge)
          ],
        ),
      ),
    );
  }

  // pay now button

  payNowButton({required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.055),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 134, 134, 134)),
          onPressed: () {},
          child: Text(
            'Pay Now',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // book and pay at hotel button

  bookAndPayAtHotel({required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.055),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 12, 85, 6)),
          onPressed: () {},
          child: Text(
            'Book Now & Pay At Hotel',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // bottom sheet of date selecting

  dateSelectingBottomSheet({required BuildContext context}) {
    log('sdfsdf');
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'From',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                EasyInfiniteDateTimeLine(
                    onDateChange: (selectedDate) {
                      print(selectedDate);
                    },
                    firstDate: DateTime.now(),
                    focusDate: DateTime.now(),
                    lastDate: DateTime(2050)),
                Text(
                  'To',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                EasyInfiniteDateTimeLine(
                    firstDate: DateTime.now(),
                    focusDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime(2050)),
              ],
            ),
          ),
        );
      },
    );
    //  return CalendarDatePicker(
    //   initialDate: DateTime.now(), firstDate: DateTime(2024), lastDate: DateTime(2050), onDateChanged: (value) {
    //  },);
    // return showModalBottomSheet(
    //   context: context,
    //   builder: (context) {
    //     return ListView(
    //       children: [

    //       ],
    //     );
    //   },
    // );
  }

  // drawer function
  drawerReturnFunction(BuildContext context) {
    return Drawer(
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? const Color.fromARGB(150, 255, 255, 255)
              : const Color.fromARGB(150, 0, 0, 0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.width * 0.45,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(150),
              ),
              image: BlocProvider.of<UserLoginBloc>(context).userModel == null
                  ? null
                  : DecorationImage(
                      image: NetworkImage(
                          BlocProvider.of<UserLoginBloc>(context)
                              .userModel!
                              .imagePath),
                      fit: BoxFit.cover),
            ),
          ),
          Text(
            BlocProvider.of<UserLoginBloc>(context).userModel!.name,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
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
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
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
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
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
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Alerts().dialgForDelete(context: context, type: 'logOut');
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
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
}
