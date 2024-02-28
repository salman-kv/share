abstract class RoomBookingState{}
class InitialRoomBookingState extends RoomBookingState{}
class RoomBookingLoadingState extends RoomBookingState{}
class RoomBookingDatePickedState extends RoomBookingState{}
class RoomBookingStartingPickedState extends RoomBookingState{}
class RoomBookingErrorState extends RoomBookingState{
  final String text;

  RoomBookingErrorState({required this.text});
}