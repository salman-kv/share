import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_event.dart';
import 'package:share/user/domain/model/room_booking_model.dart';


class Alerts {
  dialgForDelete({required BuildContext context,Function? function,String text='agree or not',RoomBookingModel? roomBookingModel}) async{
    bool val=false;
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 238, 237, 235),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(
              children: [
                const Icon(
                  Icons.warning,
                  color: Color.fromARGB(255, 244, 67, 54),
                  size: 29,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    if(text=='Cancel the room'){
                      log('cancel if working');
                      log('${roomBookingModel}');
                      BlocProvider.of<RoomBookingBloc>(context)
                                        .add(
                                      OnDeleateRoomBooking(
                                        roomBookingModel: roomBookingModel!,
                                          bookingId: roomBookingModel.bookingId!,
                                          userId:roomBookingModel.userId,),
                                    );
                                    Navigator.of(context).pop();
                                    val=true;
                    }
                    else{
                      function!(context);
                    }
                  },
                  child: Text(
                    'Yes',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.green),
                  )),
            ],
          );
        });
        return val;
  }
}
