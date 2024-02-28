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