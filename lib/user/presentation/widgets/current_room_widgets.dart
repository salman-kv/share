import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_event.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/time_function.dart';
import 'package:share/user/domain/functions/user_function.dart';
import 'package:share/user/domain/model/room_booking_model.dart';
import 'package:share/user/presentation/const/const_color.dart';
import 'package:share/user/presentation/pages/user_pages/booking_deatails/booking_deatails_page.dart';
import 'package:share/user/presentation/pages/user_pages/rating_feedback/rating_and_feedback.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class CurrentRoomWidget {
  currentEnrolledRoomContainer(
      {required BuildContext context,
      required RoomBookingModel roomBookingModel}) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
            .doc(roomBookingModel.hotelId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ConstColor().mainColorblue.withOpacity(0.3),
              ),
              constraints: const BoxConstraints(minHeight: 250),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                      Text(
                        snapshot.data!.data()![
                            FirebaseFirestoreConst.firebaseFireStoreHotelName],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text('Room : ${roomBookingModel.roomNumber}',
                          style: Theme.of(context).textTheme.displayMedium),
                      Text(
                        '₹ ${roomBookingModel.price}',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            'Checked In : ',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Expanded(
                              child: Text(
                            '${TimeFunction().toDateOnly(dateTime: roomBookingModel.checkInCheckOutModel!.checkInTime!)} - ${TimeFunction().toTimeOnly(dateTime: roomBookingModel.bookingTime)}',
                            style: Theme.of(context).textTheme.displayMedium,
                          ))
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider.value(
                                value:
                                    BlocProvider.of<RoomBookingBloc>(context),
                                child: BookingDeatailsPage(
                                  roomBookingModel: roomBookingModel,
                                ),
                              );
                            },
                          ));
                        },
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 11, 1, 93),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Booking details',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              const Icon(
                                Icons.bookmark_outline,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15, vertical: 5),
                      //   margin: const EdgeInsets.symmetric(vertical: 5),
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //       color: const Color.fromARGB(255, 11, 1, 93),
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         'Chat With Owner',
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .titleMedium!
                      //             .copyWith(color: Colors.white),
                      //       ),
                      //       const Icon(
                      //         Icons.chat,
                      //         color: Colors.white,
                      //         size: 30,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return RatingAndFeedback(roomBookingModel: roomBookingModel,);
                          },));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 11, 1, 93),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rating and feedback',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              const Icon(
                                Icons.rate_review_outlined,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'report',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.red,
                                    decorationThickness: 2),
                          ),
                        ],
                      ),
                      BlocBuilder<RoomBookingBloc, RoomBookingState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: roomBookingModel
                                          .checkInCheckOutModel!.request ==
                                      FirebaseFirestoreConst
                                          .firebaseFireStoreCheckInORcheckOutRequestForCheckOutWaiting
                                  ? const Text('waiting for checkout')
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      decoration:
                                          Styles().elevatedButtonDecration(),
                                      child: ElevatedButton(
                                        style: Styles().elevatedButtonStyle(),
                                        onPressed: () {
                                          BlocProvider.of<RoomBookingBloc>(
                                                  context)
                                              .add(
                                            OnCheckOutClicked(
                                                roomBookingModel:
                                                    roomBookingModel),
                                          );
                                        },
                                        child:state is RoomBookingLoadingState ? const CircularProgressIndicator() : Text(
                                          'Check Out Now',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                            ),
                          );
                        },
                      )
                    ]),
              ),
            );
          } else {
            return Text('no room');
          }
        });
  }
}
