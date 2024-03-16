import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/time_function.dart';
import 'package:share/user/domain/model/room_booking_model.dart';
import 'package:share/user/presentation/const/const_color.dart';

class BookingDeatailsPage extends StatelessWidget {
  RoomBookingModel roomBookingModel;
  BookingDeatailsPage({super.key, required this.roomBookingModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Booking Details',style: Theme.of(context).textTheme.titleLarge,),
              centerTitle: true,
            ),
            body: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ConstColor().mainColorblue.withOpacity(0.3),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(roomBookingModel.image),
                                  fit: BoxFit.fill)),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.1,
                          ),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Check In',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: const Color.fromARGB(
                                                  255, 218, 163, 0)),
                                    ),
                                    roomBookingModel.checkInCheckOutModel !=
                                            null
                                        ? roomBookingModel.checkInCheckOutModel!
                                                    .checkInTime !=
                                                null
                                            ? Column(
                                                children: [
                                                  Text(
                                                      '${TimeFunction().toDateOnly(dateTime: roomBookingModel.checkInCheckOutModel!.checkInTime!)}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                  Text(
                                                      '${TimeFunction().toTimeOnly(dateTime: roomBookingModel.checkInCheckOutModel!.checkInTime!)}')
                                                ],
                                              )
                                            : Text(
                                                'Not Yet Check In',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              )
                                        : Text(
                                            'Not Yet Check In',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Check Out',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: const Color.fromARGB(
                                                  255, 218, 163, 0)),
                                    ),
                                    roomBookingModel.checkInCheckOutModel !=
                                            null
                                        ? roomBookingModel.checkInCheckOutModel!
                                                    .checkOutTime !=
                                                null
                                            ? Column(
                                                children: [
                                                  Text(
                                                      '${TimeFunction().toDateOnly(dateTime: roomBookingModel.checkInCheckOutModel!.checkOutTime!)}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                  Text(
                                                      '${TimeFunction().toTimeOnly(dateTime: roomBookingModel.checkInCheckOutModel!.checkOutTime!)}')
                                                ],
                                              )
                                            : Text(
                                                'Not Yet Checkouted',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              )
                                        : Text(
                                            'Not Yet Checkouted',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                  ],
                                ),
                              ]),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(FirebaseFirestoreConst
                                  .firebaseFireStoreHotelCollection)
                              .doc(roomBookingModel.hotelId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${snapshot.data!.data()![FirebaseFirestoreConst.firebaseFireStoreHotelName]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.place),
                                          Text(
                                            '${snapshot.data!.data()![FirebaseFirestoreConst.firebaseFireStoreHotelPlace]}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.key),
                                          Text(
                                            roomBookingModel.roomNumber,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Booking Date : ${TimeFunction().toDateOnly(dateTime: roomBookingModel.bookingTime)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      Text(
                                        'Booking Time : ${TimeFunction().toTimeOnly(dateTime: roomBookingModel.bookingTime)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    ]),
                              );
                            } else {
                              return Text('No hotel');
                            }
                          },
                        ),
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.height * 0.1,
                            ),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 245, 245, 245),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: const Color.fromARGB(
                                              255, 218, 163, 0)),
                                ),
                                roomBookingModel.paymentModel != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Price : ${roomBookingModel.price}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                          Text(
                                            'Payment Id : ${roomBookingModel.paymentModel!.paymentId}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ],
                                      )
                                    : Text('Not paid',style: Theme.of(context).textTheme.displayMedium,)
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Booked For : ',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text(
                                    '${TimeFunction().toDateOnly(dateTime: roomBookingModel.bookedDate['start']!)}',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text('To',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                  Text(
                                    '${TimeFunction().toDateOnly(dateTime: roomBookingModel.bookedDate['end']!)}',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
