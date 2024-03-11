import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_event.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_state.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_bloc.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_event.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_state.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/user_function.dart';
import 'package:share/user/domain/model/checkin_checkout_model.dart';
import 'package:share/user/domain/model/room_booking_model.dart';
import 'package:share/user/domain/model/room_model.dart';
import 'package:share/user/presentation/alerts/alert.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/const/const_color.dart';
import 'package:share/user/presentation/pages/payment_page/payment_page.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class RoomBookingWidget {
  // booking container

  bookingContainer(
      {required BuildContext context, required RoomModel roomModel}) {
    return BlocConsumer<RoomBookingBloc, RoomBookingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .02,
              bottom: MediaQuery.of(context).size.height * .02),
          constraints: const BoxConstraints(minHeight: 100),
          decoration: BoxDecoration(
              color: UserFunction().backgroundColorAlmostSame(context),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: UserFunction().opositColor(context), width: 2)),
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
                          BlocProvider.of<RoomBookingBloc>(context)
                                      .startingDate ==
                                  null
                              ? BlocProvider.of<RoomBookingBloc>(context)
                                  .add(OnSelectDateTime(roomId: roomModel.id!))
                              : null;
                          dateSelectingBottomSheet(
                              context: context,
                              bloc: BlocProvider.of<RoomBookingBloc>(context));
                        },
                        child: BlocProvider.of<RoomBookingBloc>(context)
                                    .startingDate ==
                                null
                            ? const Text('SelectDate')
                            : Column(
                                children: [
                                  Text(
                                    UserFunction()
                                        .dateTimeToDateOnly(
                                            dateTime: BlocProvider.of<
                                                    RoomBookingBloc>(context)
                                                .startingDate!)
                                        .toString(),
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Text(
                                    'TO',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    UserFunction()
                                        .dateTimeToDateOnly(
                                            dateTime: BlocProvider.of<
                                                    RoomBookingBloc>(context)
                                                .endingDate!)
                                        .toString(),
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ],
                              ))
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
      },
    );
  }

  // total payment container
  totalpaymentContainer({required BuildContext context, required int price}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.06),
      decoration: BoxDecoration(
          color: ConstColor().mainColorblue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Amount', style: Theme.of(context).textTheme.titleMedium),
          context.watch<RoomBookingBloc>().startingDate == null
              ? Text(
                  '${BlocProvider.of<SingleRoomBloc>(context).roomModel!.price}')
              : Text(
                  '₹ ${context.watch<RoomBookingBloc>().endingDate!.difference(BlocProvider.of<RoomBookingBloc>(context).startingDate!).inDays * price}',
                  style: Theme.of(context).textTheme.titleLarge)
        ],
      ),
    );
  }

  // pay now button

  payNowButton({required BuildContext context, required int price}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.055),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 134, 134, 134)),
          onPressed: () async {
            BlocProvider.of<RoomBookingBloc>(context).add(
                OnNavigateByPayNoeButton(mainContext: context, price: price));
          },
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

  bookAndPayAtHotel({required BuildContext context, required int price}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.055),
        child: BlocListener<RoomBookingBloc, RoomBookingState>(
          listener: (context, state) {
            if (state is RoomBookingBookNowAndPayAtHotelSuccessState) {
              BlocProvider.of<RoomBookingBloc>(context).add(
                OnClickRoomBookingAndPayAtHotel(
                  roomBookingModel: RoomBookingModel(
                      bookingId: '',
                      hotelId:
                          context.read<SingleRoomBloc>().roomModel!.hotelId,
                      roomId: context.read<SingleRoomBloc>().roomModel!.id!,
                      userId: context.read<UserLoginBloc>().userId!,
                      roomNumber:
                          context.read<SingleRoomBloc>().roomModel!.roomNumber,
                      price: price,
                      bookedDate: {
                        'start': context.read<RoomBookingBloc>().startingDate!,
                        'end': context.read<RoomBookingBloc>().endingDate!,
                      },
                      bookingTime: DateTime.now(),
                      image:
                          context.read<SingleRoomBloc>().roomModel!.images[0],
                      paymentModel: null,
                      checkInCheckOutModel: null),
                ),
              );
              SnackBars().successSnackBar(
                  'Room is booked Please reach their before 2 hour', context);
            }
          },
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 12, 85, 6)),
            onPressed: () {
              BlocProvider.of<RoomBookingBloc>(context)
                  .add(OnCkeckToPressBookNowAndPayAtHotel());
              // BlocProvider.of<RoomBookingBloc>(context).add(
              //   OnClickRoomBookingAndPayAtHotel(
              //     roomBookingModel: RoomBookingModel(
              //         bookingId: '',
              //         hotelId:
              //             context.read<SingleRoomBloc>().roomModel!.hotelId,
              //         roomId: context.read<SingleRoomBloc>().roomModel!.id!,
              //         userId: context.read<UserLoginBloc>().userId!,
              //         roomNumber:
              //             context.read<SingleRoomBloc>().roomModel!.roomNumber,
              //         price: price,
              //         bookedDate: {
              //           'start': context.read<RoomBookingBloc>().startingDate!,
              //           'end': context.read<RoomBookingBloc>().endingDate!,
              //         },
              //         bookingTime: DateTime.now(),
              //         image:
              //             context.read<SingleRoomBloc>().roomModel!.images[0],
              //         paymentModel: null,
              //         checkInCheckOutModel: null),
              //   ),
              // );
            },
            child: Text(
              'Book Now & Pay At Hotel',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  // bottom sheet of date selecting

  dateSelectingBottomSheet(
      {required BuildContext context, required RoomBookingBloc bloc}) {
    log('sdfsdf');
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<RoomBookingBloc, RoomBookingState>(
            builder: (_, state) {
              if (state is RoomBookingLoadingState) {
                return const CircularProgressIndicator();
              } else {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'From',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      EasyInfiniteDateTimeLine(
                          disabledDates: context
                              .watch<RoomBookingBloc>()
                              .unSelectedStartingDate
                              .toList(),
                          onDateChange: (selectedDate) {
                            BlocProvider.of<RoomBookingBloc>(context).add(
                                OnClickStartingDate(
                                    startDate: UserFunction()
                                        .removingTimeFromDatetime(
                                            dateTime: selectedDate)));
                          },
                          firstDate: DateTime.now(),
                          focusDate:
                              context.watch<RoomBookingBloc>().startingDate ??
                                  DateTime.now(),
                          lastDate: DateTime(2050)),
                      Text(
                        'To',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      EasyInfiniteDateTimeLine(
                          disabledDates: context
                              .watch<RoomBookingBloc>()
                              .unSelectedEndingDate
                              .toList(),
                          onDateChange: (selectedDate) {
                            BlocProvider.of<RoomBookingBloc>(context).add(
                                OnClickEndingDate(
                                    endDate: UserFunction()
                                        .removingTimeFromDatetime(
                                            dateTime: selectedDate)));
                          },
                          firstDate: DateTime.now(),
                          focusDate:
                              context.watch<RoomBookingBloc>().endingDate ??
                                  DateTime.now().add(const Duration(days: 1)),
                          lastDate: DateTime(2050)),
                      Text(
                        'Selected Date',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                context.watch<RoomBookingBloc>().startingDate ==
                                        null
                                    ? DateFormat('d MMMM yyyy')
                                        .format(DateTime.now())
                                    : DateFormat('d MMMM yyyy').format(context
                                        .watch<RoomBookingBloc>()
                                        .startingDate!),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              context.watch<RoomBookingBloc>().startingDate !=
                                      null
                                  ? Text(
                                      DateFormat('HH:mm:s').format(context
                                          .watch<RoomBookingBloc>()
                                          .startingDate!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium)
                                  : const SizedBox()
                            ],
                          ),
                          Text('TO',
                              style: Theme.of(context).textTheme.titleMedium),
                          Column(
                            children: [
                              Text(
                                context.watch<RoomBookingBloc>().endingDate ==
                                        null
                                    ? DateFormat('d MMMM yyyy').format(
                                        DateTime.now()
                                            .add(const Duration(days: 1)))
                                    : DateFormat('d MMMM yyyy').format(context
                                        .watch<RoomBookingBloc>()
                                        .endingDate!),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              context.watch<RoomBookingBloc>().endingDate !=
                                      null
                                  ? Text(
                                      DateFormat('HH:mm:s').format(context
                                          .watch<RoomBookingBloc>()
                                          .endingDate!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium)
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                      Text(
                          'Total Days : ${context.watch<RoomBookingBloc>().endingDate != null ? context.watch<RoomBookingBloc>().endingDate!.difference(
                                context.watch<RoomBookingBloc>().startingDate!,
                              ).inDays : 1}',
                          style: Theme.of(context).textTheme.titleMedium),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.check))
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  // booking room showing container on booking user side

  bookingPendingRoom(
      {required RoomBookingModel roomBookingModel,
      required BuildContext context,
      required String bookingId}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SingleRoomBloc(),
        ),
        BlocProvider(
          create: (context) => RoomBookingBloc(),
        ),
      ],
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                ConstColor().mainColorblue.withOpacity(0.4),
                ConstColor().main2Colorblue.withOpacity(0.2),
              ]),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                    FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
                .doc(roomBookingModel.roomId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.3,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: NetworkImage(roomBookingModel.image),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    snapshot.data!.data()![
                                        FirebaseFirestoreConst
                                            .firebaseFireStoreHotelName],
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                BlocListener<RoomBookingBloc, RoomBookingState>(
                                  listener: (context, state) {
                                    if (state
                                        is RoomBookingCancelSuccessState) {
                                      SnackBars().successSnackBar(
                                          'Room booking canceled', context);
                                    }
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<RoomBookingBloc>(context)
                                          .add(OnCancelRoomBooking(
                                              roomBookingModel:
                                                  roomBookingModel,
                                              context: context,
                                              text: 'Cancel the room'));
                                      // Alerts().dialgForDelete(
                                      //   roomBookingModel: roomBookingModel,
                                      //   context: context,
                                      //   text: 'Cancel the room',
                                      // );
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                          child: Text(
                                        'cancel',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              snapshot.data!
                                  .data()![FirebaseFirestoreConst
                                      .firebaseFireStoreRoomNumber]
                                  .toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              '₹ ${roomBookingModel.price}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Column(
                              children: [
                                Text(
                                  '${UserFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['start']!)}  1:00 PM',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  'To',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  '${UserFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['end']!)}  11:30 AM',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                BlocConsumer<SingleRoomBloc, SingleRoomState>(
                                  listener: (context, state) {
                                    if (state is SingleRoomSuccessState) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) {
                                        return PaymentScreen(
                                          roomBookingModel: roomBookingModel,
                                          mainContext: context,
                                          price: roomBookingModel.price,
                                          bookingId: bookingId,
                                        );
                                      }));
                                    }
                                  },
                                  builder: (context, state) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      decoration:
                                          Styles().elevatedButtonDecration(),
                                      child: ElevatedButton(
                                        style: Styles().elevatedButtonStyle(),
                                        onPressed: () {
                                          context
                                                  .read<RoomBookingBloc>()
                                                  .startingDate =
                                              roomBookingModel
                                                  .bookedDate['start'];
                                          context
                                                  .read<RoomBookingBloc>()
                                                  .endingDate =
                                              roomBookingModel
                                                  .bookedDate['end'];
                                          BlocProvider.of<SingleRoomBloc>(
                                                  context)
                                              .add(
                                                  OnInitialRoomDeatailsAddingEvent(
                                                      id: roomBookingModel
                                                          .roomId));
                                        },
                                        child: Text(
                                          'Pay Now',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  //
  bookingConfirmedRoom(
      {required RoomBookingModel roomBookingModel,
      required BuildContext context}) {
    return BlocProvider(
      create: (context) => RoomBookingBloc(),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          //   return BlocProvider.value(
          //     value: BlocProvider.of<RoomPropertyBloc>(context),
          //     child: SingleRoomShowingPage(
          //       roomId: roomId,
          //       roomModel: roomModel,
          //     ),
          //   );
          // }));
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                ConstColor().mainColorblue.withOpacity(0.4),
                ConstColor().main2Colorblue.withOpacity(0.2),
              ]),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                    FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
                .doc(roomBookingModel.roomId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.3,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: NetworkImage(roomBookingModel.image),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.data()![FirebaseFirestoreConst
                                  .firebaseFireStoreHotelName],
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              snapshot.data!
                                  .data()![FirebaseFirestoreConst
                                      .firebaseFireStoreRoomNumber]
                                  .toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              '₹ ${roomBookingModel.price}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Column(
                              children: [
                                Text(
                                  '${UserFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['start']!)}  1:00 PM',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  'To',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  '${UserFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['end']!)}  11:30 AM',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                DateTime.now().isAfter(roomBookingModel
                                            .bookedDate['start']!
                                            .add(const Duration(hours: 1))) &&
                                        DateTime.now().isBefore(roomBookingModel
                                            .bookedDate['end']!
                                            .add(const Duration(hours: 11)))
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        decoration:
                                            Styles().elevatedButtonDecration(),
                                        child: roomBookingModel
                                                    .checkInCheckOutModel ==
                                                null
                                            ? ElevatedButton(
                                                style: Styles()
                                                    .elevatedButtonStyle(),
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              RoomBookingBloc>(
                                                          context)
                                                      .add(OnCheckInClicked(
                                                          checkInCheckOutModel:
                                                              CheckInCheckOutModel(
                                                                  checkOutTime:
                                                                      null,
                                                                  checkInTime:
                                                                      null,
                                                                  request:
                                                                      FirebaseFirestoreConst
                                                                          .firebaseFireStoreCheckInORcheckOutRequestForCheckInWaiting),
                                                          roomBookingModel:
                                                              roomBookingModel));
                                                },
                                                child: Text(
                                                  'CheckIn Now',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          color: Colors.white),
                                                ))
                                            : Center(
                                                child: Text(
                                                'waiting for confirmation',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        color: Colors.white),
                                              )))
                                    : Text(
                                        '( CheckIn on ${UserFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['start']!)} )',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 123, 123, 123)),
                                      )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
