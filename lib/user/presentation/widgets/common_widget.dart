import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/user/aplication/filter_bloc/filter_bloc.dart';
import 'package:share/user/aplication/filter_bloc/filter_event.dart';
import 'package:share/user/aplication/filter_bloc/filter_state.dart';
import 'package:share/user/aplication/search_bloc/search_bloc.dart';
import 'package:share/user/aplication/search_bloc/search_event.dart';
import 'package:share/user/aplication/search_bloc/search_state.dart';
import 'package:share/user/domain/model/room_model.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/const/const_color.dart';

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
                        BlocProvider.of<SearchBloc>(context).add(OnTapSearchEvent());
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
  List<Map<String, dynamic>> list = [
    {'name': 'All', 'select': true},
    {'name': 'Hotel', 'select': false},
    {'name': 'Dormetiory', 'select': false}
  ];
  categoryList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            list.length,
            (index) {
              return Container(
                height: 40,
                constraints: const BoxConstraints(minWidth: 100),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: list[index]['select']
                      ? Colors.black
                      : ConstColor().mainColorblue.withOpacity(0.3),
                ),
                child: Center(
                    child: Text(
                  list[index]['name'],
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: list[index]['select']
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : Colors.black),
                )),
              );
            },
          ),
        ),
      ),
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
    List<dynamic> tempImages = [];
    // tempImages.addAll(propertyModel.image);
    // log('hotel showing pimnem rebuild aaayi');
    return GestureDetector(
      // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      //   return RoomShowingPage(hotelId: hotelId, propertyModel: propertyModel);
      // })),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.circleUp),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Price - Low to High',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.circleDown),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Price - High to Low',
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01)
                  ],
                ),
              ),
            ));
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
}
