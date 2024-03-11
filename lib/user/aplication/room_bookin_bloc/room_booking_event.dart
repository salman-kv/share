import 'package:flutter/material.dart';
import 'package:share/user/domain/model/checkin_checkout_model.dart';
import 'package:share/user/domain/model/payment_model.dart';
import 'package:share/user/domain/model/room_booking_model.dart';

abstract class RoomBookingEvent{}
class OnSelectDateTime extends RoomBookingEvent{
  final String roomId;

  OnSelectDateTime({required this.roomId});
}
class OnClickStartingDate extends RoomBookingEvent{
  final DateTime startDate;

  OnClickStartingDate({required this.startDate});
}
class OnClickEndingDate extends RoomBookingEvent{
  final DateTime endDate;

  OnClickEndingDate({required this.endDate});
}
class OnClickRoomBookingPayButton extends RoomBookingEvent{
  final RoomBookingModel roomBookingModel;

  OnClickRoomBookingPayButton({required this.roomBookingModel});

}
class OnClickRoomBookingAndPayAtHotel extends RoomBookingEvent{
  final RoomBookingModel roomBookingModel;

  OnClickRoomBookingAndPayAtHotel({required this.roomBookingModel});

}
class OnDeleateRoomBooking extends RoomBookingEvent{
  final String bookingId;
  final String userId;
  final RoomBookingModel roomBookingModel;

  OnDeleateRoomBooking({required this.bookingId, required this.userId, required this.roomBookingModel});
}

class OnCheckInClicked extends RoomBookingEvent{
   CheckInCheckOutModel checkInCheckOutModel;
   RoomBookingModel roomBookingModel;

  OnCheckInClicked({required this.checkInCheckOutModel, required this.roomBookingModel});

}
class OnCheckOutClicked extends RoomBookingEvent{
   RoomBookingModel roomBookingModel;

  OnCheckOutClicked({required this.roomBookingModel});

}
class OnCancelRoomBooking extends RoomBookingEvent{
  final RoomBookingModel roomBookingModel;
  final BuildContext context;
  final String text;

  OnCancelRoomBooking({required this.roomBookingModel, required this.context, required this.text});
  
}

class OnNavigateByPayNoeButton extends RoomBookingEvent{
  final BuildContext mainContext;
  final int price;

  OnNavigateByPayNoeButton({required this.mainContext, required this.price});
}
class OnCkeckToPressBookNowAndPayAtHotel extends RoomBookingEvent{}